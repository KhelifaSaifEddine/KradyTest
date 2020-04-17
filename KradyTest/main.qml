import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import Qt3D.Core 2.0
import Qt3D.Render 2.9
import Qt3D.Input 2.0
import Qt3D.Extras 2.9

Entity {
    id: scene
    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                camera: mainCamera
                clearColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
            }
        },
        // Event Source will be set by the Qt3DQuickWindow
        InputSettings { }
    ]

    Camera {
        id: mainCamera
        position: Qt.vector3d(-10, 0, 0)
        viewCenter: Qt.vector3d(0, 0, 0)
        exposure: 1.7
        fieldOfView: 60
        nearPlane: 0.1
        farPlane: 4000000
    }

    OrbitCameraController {
        camera: mainCamera
        linearSpeed: 10
        lookSpeed: 240
    }

    SkyboxEntity {
        // Optional: Use the irradiance instead of the radiance for a simple blurry background
        // baseName: "qrc:/assets/envmaps/wobbly-bridge/wobbly_bridge_4k" + _envmapFormat + "_cube_irradiance"
        baseName: "qrc:/BrightSky"
        extension: ".dds"
        gammaCorrect: true
    }

    Entity {
        components: [
            EnvironmentLight {
                id: envLight
                irradiance: TextureLoader {
                    source: "qrc:/BrightSky.dds"

                    minificationFilter: Texture.LinearMipMapLinear
                    magnificationFilter: Texture.Linear
                    wrapMode {
                        x: WrapMode.ClampToEdge
                        y: WrapMode.ClampToEdge
                    }
                    generateMipMaps: false
                }
                specular: TextureLoader {
                    source: "qrc:/BrightSky.dds"

                    minificationFilter: Texture.LinearMipMapLinear
                    magnificationFilter: Texture.Linear
                    wrapMode {
                        x: WrapMode.ClampToEdge
                        y: WrapMode.ClampToEdge
                    }
                    generateMipMaps: false
                }
            }
        ]
        Entity {
            Transform {
                id: transform
                property real angle: 0.0

                readonly property real radianAngle: angle * 2 * Math.PI / 360
                readonly property real radius: 10
                readonly property real x: radius * Math.cos(radianAngle)
                readonly property real y: 0
                readonly property real z: radius * Math.sin(radianAngle)

                scale: 10
                translation: Qt.vector3d(x, y, z)

                NumberAnimation on angle {
                    loops: Animation.Infinite
                    duration: 10000
                    from: 0
                    to: 360
                }
            }

            PointLight {
                id: pointLight
                color: "white"
                intensity: 1
            }
            components: [ pointLight, transform ]
        }
        Entity{
            components: [
                SceneLoader{
                    source: "assets/CyborgEyeOnly.blend"
                }
            ]
        }

        /*Entity {
        components: [
            Transform {
                scale: 1.7
            },
            Mesh {
                source: "qrc:/assets/Engrenage.blend"
            },
            MetalRoughMaterial {
                id: sphereMaterial
                baseColor: scene.baseColor
                metalness: 0.2 * 8
                roughness: 0.1 * 4
            }
        ]
    }
    Mesh {
        source: "qrc:/assets/Engrenage.blend"
    }*/
    }

}
