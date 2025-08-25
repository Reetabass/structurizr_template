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
            NotificationService = container {

            }
            
            Analytics = coworkspace "Name" "Description" {

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
            NotificationService = container {

            }
            
            Analytics = container {

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
            db = Database "Database Schema" 
            bApi = BackendAPI "Backend API"
            ns = NotificationService "Notification Service"
            ana = Analytics "Analytics"
            
        }

        up -> ss "Uses"
        uv -> ss "Uses"
        urd -> ss "Uses"
        us -> ss "Uses"
        uvend -> ss "Uses"
        uvc -> ss "Uses"
        
        
        up -> ss.wa "Uses"
        ss.wa -> ss.db "Reads from and writes to"
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
            element "Person" {
                shape person
            }
        }
    }
}
ntainer {

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
            db = Database "Database Schema" 
            bApi = BackendAPI "Backend API"
            ns = NotificationService "Notification Service"
            ana = Analytics "Analytics"
            
        }

        up -> ss "Uses"
        uv -> ss "Uses"
        urd -> ss "Uses"
        us -> ss "Uses"
        uvend -> ss "Uses"
        uvc -> ss "Uses"
        
        
        up -> ss.wa "Uses"
        ss.wa -> ss.db "Reads from and writes to"
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
            element "Person" {
                shape person
            }
        }
    }
}
