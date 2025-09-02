workspace "Name" "Description" {

    !identifiers hierarchical

    model {

        archetypes {
            WebApplication = container {

            }
            MobileApp = container {

            }
            Database = container {

            }
            BackendAPI = container {

            }
            # NotificationService = container {

            # }
            Analytics = container {

            }
            SinglePageApplication = container {

            }
        } 

        up = person "Participants"
        uv = person "Volunteer"
        urd = person "Race Director"
        us = person "Spectator"
        uvend = person "Vendor"
        uvc = person "Volunteer Cordinator"
        
        
        ss = softwareSystem "Marathon Software System" {
            wa = WebApplication "Web Application"
            db = Database "Database Schema" {
                tags "Database"
            }
            bApi = BackendAPI "Backend API"
            # ns = NotificationService "Notification Service" {
            #     tags "ExternalEntity"
            # }
            ana = Analytics "Analytics"
            ma = MobileApp "Mobile App"
            spa = SinglePageApplication "Single Page Application"
        }

        ns = softwareSystem "Notification System" {
            tags "ExternalEntity"
        }

        up -> ss "Registers and recieves and shares updates from"
        uv -> ss "Recieves tasks, training material and communication updates"
        urd -> ss "Notifies participants"
        us -> ss "Access race information and track participants"
        uvend -> ss "Register, select location, access participant data"
        uvc -> ss "Manages volunteers and tasks, training and updates"
        ss -> ns "Sends notifications using"
        ns -> up "Sends notifications to"
        
        
        up -> ss.wa "Visits sydmarathon.com using"
        ss.wa -> ss.spa "Delivers to the user's web browser"
        up -> ss.ma "Registers and receives and shares updates from"
        ss.bApi -> ss.db "Reads from and writes to"
        ss.spa -> ss.bApi "Makes API calls to"
        ss.ma -> ss.bApi "Makes API calls to"
        ss.bApi -> ns "Sends notifications using"
        ss.ana -> ss.ma "Displays analytics on"
        ss.ana -> ss.wa "Displays analytics on"
    }

    views {
        systemContext ss "Diagram1" {
            include *
            autolayout lr
        }

        container ss "Diagram2" {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                color #0773af
                stroke #0773af
                strokeWidth 7
                shape roundedbox
            }
            element "Person" {
                shape person
            }
            element "Database" {
                shape cylinder
            }
            element "Boundary" {
                strokeWidth 5
            }
            element "ExternalEntity" {
                color #808080
                stroke #808080
                strokeWidth 5
                shape box
            }
            relationship "Relationship" {
                thickness 4
            }
        }
    }
}
