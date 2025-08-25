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

        up -> ss "Registers, receives updates, tracks race"
        uv -> ss "Performs assigned tasks at stations"
        urd -> ss "Manages event planning, schedules, and notifications"
        us -> ss "Tracks runners, views route info"
        uvend -> ss "Registers for expo, sets up booth, accesses demographics"
        uvc -> ss "Assigns tasks, communicates with volunteers"
        
        
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
