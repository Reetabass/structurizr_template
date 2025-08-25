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
