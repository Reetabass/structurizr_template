workspace "Name" "Description" {

    !identifiers hierarchical

    model {

         /* 
         * USERS
         *
         *
         *
         */

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


        /* 
         * USERS
         *
         *
         *
         */

        le = person "Learners"
        cc = person "Corporate Clients (HR Managers/Training Coordinators)"
        pa = person "Platform Administrators"
        C&I = person "Content Creators/Instructors"
        IT = person "IT Support Staff "
        
        
        ctp = softwareSystem "Corporate Training Platform" {
            
            wa = WebApplication "Web Application"
            db = Database "Database Schema" 
            bApi = BackendAPI "Backend API"
            ns = NotificationService "Notification Service"
            ana = Analytics "Analytics"
            
        }

        ns = softwareSystem "Notification System" {
            tags "ExternalEntity"
        }
        

        /* 
         * PUT USE CASES HERE
         *
         * CHANGES HERE NEED TO BE MADE
         *
         */
        
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
