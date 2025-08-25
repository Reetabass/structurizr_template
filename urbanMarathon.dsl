workspace "Name" "Description" {

    !identifiers hierarchical

    model {
        up = person "Participants"
        uv = person "Volunteer"
        urd = person "Race Director"
        us = person "Spectator"
        uvend = person "Vendor"
        uvc = person "Volunteer Cordinator"
        
        
        ss = softwareSystem "Marathon Software System" {
            wa = container "Web Application"
            db = container "Database Schema" {
                tags "Database"
            }
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
