import SwiftUI
import WebKit

struct PlanningMapView: UIViewRepresentable {
    @ObservedObject var viewModel: MapViewModel

    func makeUIView(context: Context) -> WKWebView {
        let contentController = WKUserContentController()
        contentController.add(context.coordinator, name: "parcelHandler")
        contentController.add(context.coordinator, name: "measureHandler")

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
        webView.loadHTMLString(html, baseURL: URL(string: "https://quyhoach.app"))

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 1. Cập nhật vị trí tỉnh thành khi thay đổi
        let lat = viewModel.selectedProvince.latitude
        let lng = viewModel.selectedProvince.longitude
        let zoom = viewModel.selectedProvince.zoomLevel
        let provinceJs = "if (window.moveToProvince) { window.moveToProvince(\(lat), \(lng), \(zoom)); }"
        uiView.evaluateJavaScript(provinceJs, completionHandler: nil)

        // 2. Cập nhật kiểu bản đồ nền (Hybrid, Satellite, Streets, Terrain)
        let baseTileUrl = viewModel.mapBackground.tileUrl
        let baseJs = "if (window.setBaseMap) { window.setBaseMap('\(baseTileUrl)'); }"
        uiView.evaluateJavaScript(baseJs, completionHandler: nil)

        // 3. Cập nhật lớp quy hoạch active
        if let active = viewModel.activeLayer {
            let isVec = active.isVector ? "true" : "false"
            let layerJs = "if (window.setPlanningLayer) { window.setPlanningLayer('\(active.id)', '\(active.tileUrlTemplate)', \(isVec), \(active.minZoom), \(active.maxZoom)); }"
            uiView.evaluateJavaScript(layerJs, completionHandler: nil)
        }

        // 4. Cập nhật độ mờ đục
        let opacityJs = "if (window.setOverlayOpacity) { window.setOverlayOpacity(\(viewModel.opacityValue)); }"
        uiView.evaluateJavaScript(opacityJs, completionHandler: nil)

        // 5. Cập nhật chế độ đo đạc (Distance / Area / None)
        let measureJs = "if (window.setMeasureMode) { window.setMeasureMode('\(viewModel.measureMode.rawValue)'); }"
        uiView.evaluateJavaScript(measureJs, completionHandler: nil)

        // 6. Cập nhật đường bao thửa đất VN-2000
        if let polygon = viewModel.activeVN2000Polygon {
            let pointsJson = polygon.coordinates.map { "[\($0.longitude), \($0.latitude)]" }.joined(separator: ",")
            let polyJs = "if (window.drawVN2000Polygon) { window.drawVN2000Polygon([\(pointsJson)]); }"
            uiView.evaluateJavaScript(polyJs, completionHandler: nil)
        } else {
            let clearPolyJs = "if (window.clearVN2000Polygon) { window.clearVN2000Polygon(); }"
            uiView.evaluateJavaScript(clearPolyJs, completionHandler: nil)
        }

        // 7. Di chuyển camera tới tọa độ đích khi tìm kiếm hoặc GPS
        if let target = viewModel.targetCoordinate {
            let flyJs = "if (window.flyToCoordinate) { window.flyToCoordinate(\(target.latitude), \(target.longitude)); }"
            uiView.evaluateJavaScript(flyJs, completionHandler: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKScriptMessageHandler {
        var parent: PlanningMapView
        weak var webView: WKWebView?

        init(_ parent: PlanningMapView) {
            self.parent = parent
        }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "parcelHandler", let body = message.body as? [String: Any],
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
            } else if message.name == "measureHandler", let body = message.body as? [String: Any] {
                let dist = body["distance"] as? Double ?? 0.0
                let area = body["area"] as? Double ?? 0.0
                let count = body["count"] as? Int ?? 0
                DispatchQueue.main.async {
                    self.parent.viewModel.measuredDistanceMeters = dist
                    self.parent.viewModel.measuredAreaSquareMeters = area
                    self.parent.viewModel.measuredPointsCount = count
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
        let minZ = defaultLayer?.minZoom ?? 8
        let maxZ = defaultLayer?.maxZoom ?? 19
        let opacity = viewModel.opacityValue
        let baseTile = viewModel.mapBackground.tileUrl

        return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
            <link rel="stylesheet" href="https://unpkg.com/maplibre-gl@4.7.1/dist/maplibre-gl.css" />
            <script src="https://unpkg.com/maplibre-gl@4.7.1/dist/maplibre-gl.js"></script>
            <style>
                html, body, #map {
                    height: 100%;
                    width: 100%;
                    margin: 0;
                    padding: 0;
                    background-color: #0f172a;
                }
                .maplibregl-ctrl-attrib, .maplibregl-ctrl-logo { display: none !important; }
                .measure-marker {
                    width: 12px;
                    height: 12px;
                    background-color: #3b82f6;
                    border: 2px solid white;
                    border-radius: 50%;
                    box-shadow: 0 0 8px rgba(0,0,0,0.5);
                }
                .measure-label {
                    background-color: rgba(15, 23, 42, 0.85);
                    color: #fff;
                    font-size: 11px;
                    font-weight: bold;
                    padding: 2px 6px;
                    border-radius: 6px;
                    border: 1px solid rgba(255,255,255,0.3);
                    white-space: nowrap;
                }
            </style>
        </head>
        <body>
            <div id="map"></div>
            <script>
                var currentOpacity = \(opacity);
                var currentLayerId = '\(layerId)';
                var currentUrl = '\(layerUrl)';
                var currentIsVector = \(isVector ? "true" : "false");
                var currentBaseUrl = '\(baseTile)';
                var currentMeasureMode = 'Không đo';
                var measurePoints = [];
                var measureMarkers = [];

                var map = new maplibregl.Map({
                    container: 'map',
                    center: [\(defaultProv.longitude), \(defaultProv.latitude)],
                    zoom: \(defaultProv.zoomLevel),
                    style: {
                        version: 8,
                        sources: {
                            'base-map-source': {
                                type: 'raster',
                                tiles: [currentBaseUrl],
                                tileSize: 256
                            }
                        },
                        layers: [
                            {
                                id: 'base-map-layer',
                                type: 'raster',
                                source: 'base-map-source'
                            }
                        ]
                    }
                });

                function applyPlanningLayer(id, url, isVec, minZ, maxZ) {
                    currentLayerId = id;
                    currentUrl = url;
                    currentIsVector = isVec;

                    ['qhc-fill', 'qhc-line', 'qhpk-fill', 'qhpk-line', 'vector-fill', 'vector-line', 'raster-overlay-layer'].forEach(function(lid) {
                        if (map.getLayer(lid)) map.removeLayer(lid);
                    });
                    if (map.getSource('vector-source')) map.removeSource('vector-source');
                    if (map.getSource('raster-source')) map.removeSource('raster-source');

                    if (isVec) {
                        map.addSource('vector-source', {
                            type: 'vector',
                            tiles: [url],
                            minzoom: minZ || 8,
                            maxzoom: maxZ || 19
                        });

                        if (id === 'hanoi-vector-qhc') {
                            map.addLayer({
                                id: 'qhc-fill',
                                type: 'fill',
                                source: 'vector-source',
                                'source-layer': 'zoning',
                                filter: ['==', ['get', 'grp'], 'QHC'],
                                paint: {
                                    'fill-color': ['coalesce', ['get', 'fc'], '#10B981'],
                                    'fill-opacity': currentOpacity
                                }
                            });
                            map.addLayer({
                                id: 'qhc-line',
                                type: 'line',
                                source: 'vector-source',
                                'source-layer': 'zoning',
                                filter: ['==', ['get', 'grp'], 'QHC'],
                                paint: {
                                    'line-color': ['coalesce', ['get', 'fc'], '#059669'],
                                    'line-width': 0.8,
                                    'line-opacity': currentOpacity * 0.9
                                }
                            });
                        } else if (id === 'hanoi-vector-qhpk') {
                            map.addLayer({
                                id: 'qhpk-fill',
                                type: 'fill',
                                source: 'vector-source',
                                'source-layer': 'zoning',
                                filter: ['==', ['get', 'grp'], 'QHPK'],
                                paint: {
                                    'fill-color': ['coalesce', ['get', 'fc'], '#F59E0B'],
                                    'fill-opacity': currentOpacity
                                }
                            });
                            map.addLayer({
                                id: 'qhpk-line',
                                type: 'line',
                                source: 'vector-source',
                                'source-layer': 'zoning',
                                filter: ['==', ['get', 'grp'], 'QHPK'],
                                paint: {
                                    'line-color': ['coalesce', ['get', 'fc'], '#D97706'],
                                    'line-width': 0.8,
                                    'line-opacity': currentOpacity * 0.9
                                }
                            });
                        } else {
                            map.addLayer({
                                id: 'vector-fill',
                                type: 'fill',
                                source: 'vector-source',
                                'source-layer': 'zoning',
                                paint: {
                                    'fill-color': ['coalesce', ['get', 'fc'], '#3B82F6'],
                                    'fill-opacity': currentOpacity
                                }
                            });
                        }
                    } else {
                        map.addSource('raster-source', {
                            type: 'raster',
                            tiles: [url],
                            tileSize: 256,
                            minzoom: minZ || 8,
                            maxzoom: maxZ || 19
                        });
                        map.addLayer({
                            id: 'raster-overlay-layer',
                            type: 'raster',
                            source: 'raster-source',
                            paint: {
                                'raster-opacity': currentOpacity,
                                'raster-resampling': 'linear'
                            }
                        });
                    }

                    setupVN2000AndMeasureLayers();
                }

                function setupVN2000AndMeasureLayers() {
                    // VN2000 Source & Layers
                    if (!map.getSource('vn2000-source')) {
                        map.addSource('vn2000-source', {
                            type: 'geojson',
                            data: { type: 'FeatureCollection', features: [] }
                        });
                        map.addLayer({
                            id: 'vn2000-fill',
                            type: 'fill',
                            source: 'vn2000-source',
                            paint: {
                                'fill-color': '#EF4444',
                                'fill-opacity': 0.35
                            }
                        });
                        map.addLayer({
                            id: 'vn2000-line',
                            type: 'line',
                            source: 'vn2000-source',
                            paint: {
                                'line-color': '#DC2626',
                                'line-width': 3,
                                'line-dasharray': [2, 1]
                            }
                        });
                    }

                    // Measurement Source & Layers
                    if (!map.getSource('measure-source')) {
                        map.addSource('measure-source', {
                            type: 'geojson',
                            data: { type: 'FeatureCollection', features: [] }
                        });
                        map.addLayer({
                            id: 'measure-fill',
                            type: 'fill',
                            source: 'measure-source',
                            paint: {
                                'fill-color': '#3B82F6',
                                'fill-opacity': 0.3
                            }
                        });
                        map.addLayer({
                            id: 'measure-line',
                            type: 'line',
                            source: 'measure-source',
                            paint: {
                                'line-color': '#2563EB',
                                'line-width': 2.5
                            }
                        });
                    }
                }

                map.on('load', function() {
                    applyPlanningLayer(currentLayerId, currentUrl, currentIsVector, \(minZ), \(maxZ));
                });

                // Public JS Bridge Functions
                window.moveToProvince = function(lat, lng, zoom) {
                    map.flyTo({ center: [lng, lat], zoom: zoom, duration: 1200 });
                };

                window.setBaseMap = function(tileUrl) {
                    if (currentBaseUrl !== tileUrl && map.getSource('base-map-source')) {
                        currentBaseUrl = tileUrl;
                        if (map.getLayer('base-map-layer')) map.removeLayer('base-map-layer');
                        map.removeSource('base-map-source');
                        map.addSource('base-map-source', {
                            type: 'raster',
                            tiles: [tileUrl],
                            tileSize: 256
                        });
                        // Đặt base map dưới cùng
                        var firstLayer = map.getStyle().layers[0] ? map.getStyle().layers[0].id : undefined;
                        map.addLayer({
                            id: 'base-map-layer',
                            type: 'raster',
                            source: 'base-map-source'
                        }, firstLayer);
                    }
                };

                window.setPlanningLayer = function(id, url, isVec, minZ, maxZ) {
                    if (map.isStyleLoaded()) {
                        applyPlanningLayer(id, url, isVec, minZ, maxZ);
                    }
                };

                window.setOverlayOpacity = function(val) {
                    currentOpacity = val;
                    if (map.getLayer('raster-overlay-layer')) {
                        map.setPaintProperty('raster-overlay-layer', 'raster-opacity', val);
                    }
                    ['qhc-fill', 'qhpk-fill', 'vector-fill'].forEach(function(lid) {
                        if (map.getLayer(lid)) map.setPaintProperty(lid, 'fill-opacity', val);
                    });
                    ['qhc-line', 'qhpk-line', 'vector-line'].forEach(function(lid) {
                        if (map.getLayer(lid)) map.setPaintProperty(lid, 'line-opacity', val * 0.9);
                    });
                };

                window.flyToCoordinate = function(lat, lng) {
                    map.flyTo({ center: [lng, lat], zoom: 16.5, duration: 1500 });
                };

                window.zoomIn = function() { map.zoomIn(); };
                window.zoomOut = function() { map.zoomOut(); };
                window.resetNorth = function() { map.resetNorthPitch({ duration: 800 }); };

                // Measurement Tools JS
                window.setMeasureMode = function(mode) {
                    currentMeasureMode = mode;
                    if (mode === 'Không đo') {
                        clearMeasurementState();
                    }
                };

                function clearMeasurementState() {
                    measurePoints = [];
                    measureMarkers.forEach(function(m) { m.remove(); });
                    measureMarkers = [];
                    if (map.getSource('measure-source')) {
                        map.getSource('measure-source').setData({ type: 'FeatureCollection', features: [] });
                    }
                }

                function calculateDistanceMeters(p1, p2) {
                    var R = 6371000; // meters
                    var dLat = (p2[1] - p1[1]) * Math.PI / 180;
                    var dLon = (p2[0] - p1[0]) * Math.PI / 180;
                    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                            Math.cos(p1[1] * Math.PI / 180) * Math.cos(p2[1] * Math.PI / 180) *
                            Math.sin(dLon/2) * Math.sin(dLon/2);
                    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
                    return R * c;
                }

                function calculateAreaMeters(coords) {
                    if (coords.length < 3) return 0;
                    var area = 0;
                    var R = 6371000;
                    var radCoords = coords.map(function(c) {
                        return [c[0] * Math.PI / 180, c[1] * Math.PI / 180];
                    });
                    for (var i = 0; i < radCoords.length; i++) {
                        var p1 = radCoords[i];
                        var p2 = radCoords[(i + 1) % radCoords.length];
                        area += (p2[0] - p1[0]) * (2 + Math.sin(p1[1]) + Math.sin(p2[1]));
                    }
                    area = Math.abs(area * R * R / 2.0);
                    return area;
                }

                function updateMeasureDisplay() {
                    var totalDist = 0;
                    for (var i = 0; i < measurePoints.length - 1; i++) {
                        totalDist += calculateDistanceMeters(measurePoints[i], measurePoints[i+1]);
                    }

                    var totalArea = 0;
                    if (currentMeasureMode === 'Đo diện tích' && measurePoints.length >= 3) {
                        totalArea = calculateAreaMeters(measurePoints);
                    }

                    var feature;
                    if (currentMeasureMode === 'Đo diện tích' && measurePoints.length >= 3) {
                        var closed = measurePoints.slice();
                        closed.push(measurePoints[0]);
                        feature = {
                            type: 'Feature',
                            geometry: { type: 'Polygon', coordinates: [closed] }
                        };
                    } else if (measurePoints.length >= 2) {
                        feature = {
                            type: 'Feature',
                            geometry: { type: 'LineString', coordinates: measurePoints }
                        };
                    }

                    if (map.getSource('measure-source')) {
                        map.getSource('measure-source').setData({
                            type: 'FeatureCollection',
                            features: feature ? [feature] : []
                        });
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

                // VN2000 Boundary Polygon
                window.drawVN2000Polygon = function(coords) {
                    if (!coords || coords.length < 3) return;
                    setupVN2000AndMeasureLayers();
                    var closedCoords = coords.slice();
                    closedCoords.push(coords[0]);
                    if (map.getSource('vn2000-source')) {
                        map.getSource('vn2000-source').setData({
                            type: 'FeatureCollection',
                            features: [{
                                type: 'Feature',
                                geometry: { type: 'Polygon', coordinates: [closedCoords] }
                            }]
                        });
                    }
                    var bounds = coords.reduce(function(b, c) { return b.extend(c); }, new maplibregl.LngLatBounds(coords[0], coords[0]));
                    map.fitBounds(bounds, { padding: 80, maxZoom: 18.5, duration: 1500 });
                };

                window.clearVN2000Polygon = function() {
                    if (map.getSource('vn2000-source')) {
                        map.getSource('vn2000-source').setData({ type: 'FeatureCollection', features: [] });
                    }
                };

                // Map Click Handling
                map.on('click', function(e) {
                    var lat = e.lngLat.lat;
                    var lng = e.lngLat.lng;

                    // Nếu đang ở chế độ đo đạc
                    if (currentMeasureMode !== 'Không đo') {
                        measurePoints.push([lng, lat]);
                        var el = document.createElement('div');
                        el.className = 'measure-marker';
                        var marker = new maplibregl.Marker({ element: el }).setLngLat([lng, lat]).addTo(map);
                        measureMarkers.push(marker);
                        updateMeasureDisplay();
                        return;
                    }

                    // Tra cứu thửa đất bình thường
                    var landName = '';
                    var landGrp = '';
                    var landCode = '';

                    var clickable = ['qhc-fill', 'qhpk-fill', 'vector-fill'].filter(function(id) { return !!map.getLayer(id); });
                    if (clickable.length > 0) {
                        var feats = map.queryRenderedFeatures(e.point, { layers: clickable });
                        if (feats && feats.length > 0) {
                            var p = feats[0].properties || {};
                            landName = p.name || '';
                            landGrp = p.grp || '';
                            landCode = p.lno || p.ma || '';
                        }
                    }

                    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.parcelHandler) {
                        window.webkit.messageHandlers.parcelHandler.postMessage({
                            lat: lat,
                            lng: lng,
                            landTypeName: landName,
                            grpName: landGrp,
                            landCode: landCode
                        });
                    }
                });
            </script>
        </body>
        </html>
        """
    }
}
