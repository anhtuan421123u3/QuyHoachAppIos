import SwiftUI
import WebKit
import CoreLocation

struct PlanningMapView: UIViewRepresentable {
    @ObservedObject var viewModel: MapViewModel

    func makeUIView(context: Context) -> WKWebView {
        let contentController = WKUserContentController()
        contentController.add(context.coordinator, name: "parcelHandler")
        contentController.add(context.coordinator, name: "measureHandler")
        contentController.add(context.coordinator, name: "mapReadyHandler")
        contentController.add(context.coordinator, name: "logHandler")

        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        config.allowsInlineMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        context.coordinator.webView = webView

        let html = generateMapHtml()
        webView.loadHTMLString(html, baseURL: nil)

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard context.coordinator.isMapReady else { return }
        context.coordinator.syncToMap(uiView: uiView)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKScriptMessageHandler {
        var parent: PlanningMapView
        weak var webView: WKWebView?
        var isMapReady = false

        init(_ parent: PlanningMapView) {
            self.parent = parent
        }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            switch message.name {
            case "mapReadyHandler":
                self.isMapReady = true
                if let wv = self.webView {
                    self.syncToMap(uiView: wv)
                }
            case "logHandler":
                #if DEBUG
                print("[Map JS Log]", message.body)
                #endif
            case "parcelHandler":
                if let body = message.body as? [String: Any],
                   let lat = body["lat"] as? Double,
                   let lng = body["lng"] as? Double {
                    let landTypeName = body["landTypeName"] as? String
                    let grpName = body["grpName"] as? String
                    let landCode = body["landCode"] as? String
                    DispatchQueue.main.async {
                        self.parent.viewModel.inspectAtCoordinate(
                            lat: lat,
                            lng: lng,
                            landTypeName: landTypeName,
                            grpName: grpName,
                            landCode: landCode
                        )
                    }
                }
            case "measureHandler":
                if let body = message.body as? [String: Any] {
                    let dist = body["distance"] as? Double ?? 0.0
                    let area = body["area"] as? Double ?? 0.0
                    let count = body["count"] as? Int ?? 0
                    DispatchQueue.main.async {
                        self.parent.viewModel.measuredDistanceMeters = dist
                        self.parent.viewModel.measuredAreaSquareMeters = area
                        self.parent.viewModel.measuredPointsCount = count
                    }
                }
            default:
                break
            }
        }

        func syncToMap(uiView: WKWebView) {
            let prov = parent.viewModel.selectedProvince
            let base = parent.viewModel.mapBackground
            let activeLayer = parent.viewModel.activeLayer
            let vm = parent.viewModel

            // 1. Di chuyển camera khi TỈNH thay đổi
            if prov.id != vm.lastFlyToProvinceId {
                let lat = prov.latitude; let lng = prov.longitude; let zoom = prov.zoomLevel
                uiView.evaluateJavaScript("if(window.moveToProvince){window.moveToProvince(\(lat),\(lng),\(zoom));}", completionHandler: nil)
            }

            // 2. Đổi base map khi mapBackground thay đổi
            if base.rawValue != vm.lastFlyToBase {
                uiView.evaluateJavaScript("if(window.setBaseMap){window.setBaseMap('\(base.tileUrl)');}", completionHandler: nil)
            }

            // 3. Cập nhật lớp quy hoạch khi activeLayer thay đổi
            let currentLayerId = activeLayer?.id ?? ""
            if currentLayerId != vm.lastFlyToLayerId {
                if let active = activeLayer {
                    let isVec = active.isVector ? "true" : "false"
                    uiView.evaluateJavaScript(
                        "if(window.setPlanningLayer){window.setPlanningLayer('\(active.id)','\(active.tileUrlTemplate)',\(isVec),\(active.minZoom),\(active.maxZoom));}",
                        completionHandler: nil
                    )
                } else {
                    uiView.evaluateJavaScript("if(window.clearPlanningLayer){window.clearPlanningLayer();}", completionHandler: nil)
                }
            }

            // Ghi nhận trạng thái để không trigger lặp lại
            vm.markCameraAsFlown(
                coord: CLLocationCoordinate2D(latitude: prov.latitude, longitude: prov.longitude),
                provinceId: prov.id,
                layerId: currentLayerId,
                base: base.rawValue
            )

            // 2. Độ mờ đục quy hoạch
            uiView.evaluateJavaScript("if(window.setOverlayOpacity){window.setOverlayOpacity(\(vm.opacityValue));}", completionHandler: nil)

            // 3. Chế độ đo đạc
            uiView.evaluateJavaScript("if(window.setMeasureMode){window.setMeasureMode('\(vm.measureMode.rawValue)');}", completionHandler: nil)

            // 4. VN-2000 Polygon ranh giới thửa
            if let polygon = vm.activeVN2000Polygon {
                let pointsJson = polygon.coordinates.map { "[\($0.latitude), \($0.longitude)]" }.joined(separator: ",")
                uiView.evaluateJavaScript("if(window.drawVN2000Polygon){window.drawVN2000Polygon([\(pointsJson)]);}", completionHandler: nil)
            } else {
                uiView.evaluateJavaScript("if(window.clearVN2000Polygon){window.clearVN2000Polygon();}", completionHandler: nil)
            }

            // 5. Tọa độ tìm kiếm / GPS
            if let target = vm.targetCoordinate {
                let tc = target
                let alreadySentFly = vm.lastFlyToCoord.map {
                    abs($0.latitude - tc.latitude) < 0.00001 && abs($0.longitude - tc.longitude) < 0.00001
                } ?? false
                if !alreadySentFly {
                    uiView.evaluateJavaScript("if(window.flyToCoordinate){window.flyToCoordinate(\(tc.latitude),\(tc.longitude));}", completionHandler: nil)
                    vm.markCameraAsFlown(
                        coord: tc,
                        provinceId: prov.id,
                        layerId: activeLayer?.id ?? "",
                        base: base.rawValue
                    )
                }
            }
        }
    }

    private func generateMapHtml() -> String {
        let defaultProv = viewModel.selectedProvince
        let defaultLayer = viewModel.activeLayer
        let layerUrl = defaultLayer?.tileUrlTemplate ?? defaultProv.tileUrlTemplate
        let isVector = defaultLayer?.isVector ?? false
        let layerId = defaultLayer?.id ?? "default-layer"
        let minZ = defaultLayer?.minZoom ?? 5
        let maxZ = defaultLayer?.maxZoom ?? 22
        let opacity = viewModel.opacityValue
        let baseTile = viewModel.mapBackground.tileUrl

        return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
            <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
            <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
            <style>
                html, body, #map {
                    height: 100%;
                    width: 100%;
                    margin: 0;
                    padding: 0;
                    overflow: hidden;
                    background-color: #0f172a;
                    -webkit-tap-highlight-color: transparent;
                }
                .leaflet-control-container .leaflet-top,
                .leaflet-control-container .leaflet-bottom {
                    display: none !important;
                }
                .measure-dot {
                    width: 12px;
                    height: 12px;
                    background-color: #3b82f6;
                    border: 2px solid white;
                    border-radius: 50%;
                    box-shadow: 0 0 6px rgba(0,0,0,0.6);
                }
                .pulse-pin {
                    width: 22px;
                    height: 22px;
                    background: rgba(16, 185, 129, 0.4);
                    border: 3px solid #10b981;
                    border-radius: 50%;
                    box-shadow: 0 0 10px #10b981;
                    animation: pulse 1.5s infinite;
                }
                @keyframes pulse {
                    0% { transform: scale(0.9); opacity: 0.9; }
                    50% { transform: scale(1.3); opacity: 0.5; }
                    100% { transform: scale(0.9); opacity: 0.9; }
                }
            </style>
        </head>
        <body>
            <div id="map"></div>
            <script>
                // Log bridge
                window.console.log = function() {
                    try {
                        var msg = Array.prototype.slice.call(arguments).join(' ');
                        if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.logHandler) {
                            window.webkit.messageHandlers.logHandler.postMessage(msg);
                        }
                    } catch(e) {}
                };
                window.console.error = function() {
                    try {
                        var msg = Array.prototype.slice.call(arguments).join(' ');
                        if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.logHandler) {
                            window.webkit.messageHandlers.logHandler.postMessage('ERROR: ' + msg);
                        }
                    } catch(e) {}
                };

                var currentOpacity = \(opacity);
                var currentLayerId = '\(layerId)';
                var currentUrl = '\(layerUrl)';
                var currentBaseUrl = '\(baseTile)';
                var currentMeasureMode = 'Không đo';
                var measurePoints = [];
                var measureMarkers = [];
                var measureLine = null;
                var measureAreaPolygon = null;
                var vn2000Layer = null;
                var pinMarker = null;

                // 1. Khởi tạo bản đồ Leaflet chuẩn Guland
                var map = L.map('map', {
                    center: [\(defaultProv.latitude), \(defaultProv.longitude)],
                    zoom: \(defaultProv.zoomLevel),
                    zoomControl: false,
                    attributionControl: false,
                    inertia: true,
                    inertiaDeceleration: 3000
                });

                // 2. Base map layer (Google Hybrid / Satellite / Maps)
                var baseLayer = L.tileLayer(currentBaseUrl, {
                    maxZoom: 22,
                    maxNativeZoom: 20
                }).addTo(map);

                // 3. Planning overlay layer (Guland CDN tiles)
                var planLayer = null;
                function applyPlanningLayer(id, url, minZ, maxZ) {
                    currentLayerId = id;
                    currentUrl = url;
                    if (planLayer) {
                        map.removeLayer(planLayer);
                        planLayer = null;
                    }
                    if (url && url.length > 0) {
                        planLayer = L.tileLayer(url, {
                            opacity: currentOpacity,
                            minZoom: minZ || 5,
                            maxZoom: 22,
                            maxNativeZoom: maxZ || 18,
                            tileSize: 256
                        }).addTo(map);
                    }
                }

                // Nạp ngay lớp quy hoạch ban đầu
                applyPlanningLayer(currentLayerId, currentUrl, \(minZ), \(maxZ));

                // 4. Các hàm giao tiếp Swift <-> JS
                window.moveToProvince = function(lat, lng, zoom) {
                    map.flyTo([lat, lng], zoom, { duration: 1.0 });
                };

                window.setBaseMap = function(tileUrl) {
                    if (currentBaseUrl !== tileUrl) {
                        currentBaseUrl = tileUrl;
                        if (baseLayer) map.removeLayer(baseLayer);
                        baseLayer = L.tileLayer(tileUrl, {
                            maxZoom: 22,
                            maxNativeZoom: 20
                        }).addTo(map);
                        baseLayer.bringToBack();
                    }
                };

                window.setPlanningLayer = function(id, url, isVec, minZ, maxZ) {
                    applyPlanningLayer(id, url, minZ, maxZ);
                };

                window.clearPlanningLayer = function() {
                    currentLayerId = '';
                    currentUrl = '';
                    if (planLayer) {
                        map.removeLayer(planLayer);
                        planLayer = null;
                    }
                };

                window.setOverlayOpacity = function(val) {
                    currentOpacity = val;
                    if (planLayer) {
                        planLayer.setOpacity(val);
                    }
                };

                window.flyToCoordinate = function(lat, lng) {
                    map.flyTo([lat, lng], 17, { duration: 1.2 });
                    if (pinMarker) map.removeLayer(pinMarker);
                    var icon = L.divIcon({ className: 'pulse-pin', iconSize: [22, 22], iconAnchor: [11, 11] });
                    pinMarker = L.marker([lat, lng], { icon: icon }).addTo(map);
                };

                window.zoomIn = function() { map.zoomIn(); };
                window.zoomOut = function() { map.zoomOut(); };
                window.resetNorth = function() { map.setView(map.getCenter(), map.getZoom()); };

                // Measurement Tools
                window.setMeasureMode = function(mode) {
                    currentMeasureMode = mode;
                    if (mode === 'Không đo') {
                        clearMeasurement();
                    }
                };

                function clearMeasurement() {
                    measurePoints = [];
                    measureMarkers.forEach(function(m) { map.removeLayer(m); });
                    measureMarkers = [];
                    if (measureLine) { map.removeLayer(measureLine); measureLine = null; }
                    if (measureAreaPolygon) { map.removeLayer(measureAreaPolygon); measureAreaPolygon = null; }
                }

                function degToRad(deg) { return deg * Math.PI / 180; }

                function computeDistanceMeters(p1, p2) {
                    var R = 6371000;
                    var dLat = degToRad(p2[0] - p1[0]);
                    var dLon = degToRad(p2[1] - p1[1]);
                    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                            Math.cos(degToRad(p1[0])) * Math.cos(degToRad(p2[0])) *
                            Math.sin(dLon/2) * Math.sin(dLon/2);
                    return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
                }

                function computeAreaSqMeters(coords) {
                    if (coords.length < 3) return 0;
                    var area = 0;
                    var R = 6371000;
                    for (var i = 0; i < coords.length; i++) {
                        var p1 = coords[i];
                        var p2 = coords[(i + 1) % coords.length];
                        area += degToRad(p2[1] - p1[1]) * (2 + Math.sin(degToRad(p1[0])) + Math.sin(degToRad(p2[0])));
                    }
                    return Math.abs(area * R * R / 2.0);
                }

                function updateMeasureDisplay() {
                    var totalDist = 0;
                    for (var i = 0; i < measurePoints.length - 1; i++) {
                        totalDist += computeDistanceMeters(measurePoints[i], measurePoints[i+1]);
                    }
                    var totalArea = 0;
                    if (currentMeasureMode === 'Đo diện tích' && measurePoints.length >= 3) {
                        totalArea = computeAreaSqMeters(measurePoints);
                    }

                    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.measureHandler) {
                        window.webkit.messageHandlers.measureHandler.postMessage({
                            mode: currentMeasureMode,
                            distance: totalDist,
                            area: totalArea,
                            count: measurePoints.length
                        });
                    }
                }

                // VN2000 Boundary
                window.drawVN2000Polygon = function(coords) {
                    if (!coords || coords.length < 3) return;
                    if (vn2000Layer) map.removeLayer(vn2000Layer);
                    vn2000Layer = L.polygon(coords, {
                        color: '#DC2626',
                        weight: 3,
                        dashArray: '6, 6',
                        fillColor: '#EF4444',
                        fillOpacity: 0.35
                    }).addTo(map);
                    map.fitBounds(vn2000Layer.getBounds(), { padding: [50, 50], maxZoom: 18 });
                };

                window.clearVN2000Polygon = function() {
                    if (vn2000Layer) {
                        map.removeLayer(vn2000Layer);
                        vn2000Layer = null;
                    }
                };

                // Map Click
                map.on('click', function(e) {
                    var lat = e.latlng.lat;
                    var lng = e.latlng.lng;

                    if (currentMeasureMode !== 'Không đo') {
                        measurePoints.push([lat, lng]);
                        var icon = L.divIcon({ className: 'measure-dot', iconSize: [12, 12], iconAnchor: [6, 6] });
                        var m = L.marker([lat, lng], { icon: icon }).addTo(map);
                        measureMarkers.push(m);

                        if (currentMeasureMode === 'Đo khoảng cách') {
                            if (measureLine) map.removeLayer(measureLine);
                            measureLine = L.polyline(measurePoints, { color: '#3B82F6', weight: 3 }).addTo(map);
                        } else if (currentMeasureMode === 'Đo diện tích') {
                            if (measureAreaPolygon) map.removeLayer(measureAreaPolygon);
                            measureAreaPolygon = L.polygon(measurePoints, { color: '#3B82F6', weight: 2.5, fillColor: '#60A5FA', fillOpacity: 0.35 }).addTo(map);
                        }
                        updateMeasureDisplay();
                        return;
                    }

                    // Đặt ghim vị trí đã chọn
                    if (pinMarker) map.removeLayer(pinMarker);
                    var pinIcon = L.divIcon({ className: 'pulse-pin', iconSize: [22, 22], iconAnchor: [11, 11] });
                    pinMarker = L.marker([lat, lng], { icon: pinIcon }).addTo(map);

                    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.parcelHandler) {
                        window.webkit.messageHandlers.parcelHandler.postMessage({
                            lat: lat,
                            lng: lng,
                            landTypeName: '',
                            grpName: '',
                            landCode: ''
                        });
                    }
                });

                // Báo hiệu map đã khởi tạo thành công tới Swift
                setTimeout(function() {
                    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.mapReadyHandler) {
                        window.webkit.messageHandlers.mapReadyHandler.postMessage('ready');
                    }
                }, 50);
            </script>
        </body>
        </html>
        """
    }
}
