//
// Created by Karel Dohnal on 10.04.2022.
//

import SwiftUI
import MapboxMaps

struct MapBoxMapView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
    }
}

class MapViewController: UIViewController {
    internal var mapView: MapView!
    internal var cameraLocationConsumer: CameraLocationConsumer!

    override public func viewDidLoad() {
        super.viewDidLoad()
        let myResourceOptions = ResourceOptions(accessToken: "pk.eyJ1IjoiZGV2ZWxvcGVyYmxpemtvIiwiYSI6ImNsMXV3aHA5cTA0NWIzZGwzeHBkaTRobTQifQ.-88QomT3ZxE5RzYt-7hg3g")
        let myCameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 50.0803, longitude: 14.4289), zoom: 10)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, cameraOptions: myCameraOptions)

        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)

        //START ANNOTATION
        // We want to display the annotation at the center of the map's current viewport
        let annotationCoordinate = CLLocationCoordinate2D(latitude: 50.0838, longitude: 14.5047)

        // Make a `PointAnnotationManager` which will be responsible for managing a
        // collection of `PointAnnotation`s.
        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()

        // Initialize a point annotation with a single coordinate
        // and configure it with a custom image (sourced from the asset catalogue)
        var customPointAnnotation = PointAnnotation(coordinate: annotationCoordinate)

        // Make the annotation show a red pin
        customPointAnnotation.image = .init(image: UIImage(named: "customPointAnnotation")!, name: "customPointAnnotation")

        // Add the annotation to the manager in order to render it on the map.
        pointAnnotationManager.annotations = [customPointAnnotation]


        cameraLocationConsumer = CameraLocationConsumer(mapView: mapView)
        // Add user position icon to the map with location indicator layer
        mapView.location.options.puckType = .puck2D()

        // Allows the delegate to receive information about map events.
        mapView.mapboxMap.onNext(.mapLoaded) { _ in
        // Register the location consumer with the map
        // Note that the location manager holds weak references to consumers, which should be retained
            self.mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
        }
    }
}

// Create class which conforms to LocationConsumer, update the camera's centerCoordinate when a locationUpdate is received
public class CameraLocationConsumer: LocationConsumer {
    weak var mapView: MapView?

    init(mapView: MapView) {
        self.mapView = mapView
    }

    public func locationUpdate(newLocation: Location) {
        mapView?.camera.ease(
                to: CameraOptions(center: newLocation.coordinate, zoom: 15),
                duration: 1.3)
    }
}