workspace "Corporate Training Platform" "Context diagram for the Corporate Training Platform." {

    !identifiers hierarchical

    model {

        archetypes {
            WebApplication = container {
                tags "Web"
            }
            MobileApp = container {
                tags "Mobile"
            }
            Data = container {
                tags "Database"
            }
        } 

        /* Users TODO: add descriptions*/

        le = person "Learners" 
        cc = person "Corporate Clients (HR Managers/Training Coordinators)"
        pa = person "Platform Administrators"
        ci = person "Content Creators/Instructors"
        it = person "IT Support Staff "

        /* System  TODO: add actual technologies being used for each container */
        ctp = softwareSystem "Corporate Training Platform" {
            
            wa = WebApplication "Web Application" "Allows users to access the platform from browsers."
            ma = MobileApp "Mobile Application" "Enables learners to access training on the go."

            // Backend API (expanded with components)
            api = container "Backend API" "Provides APIs for clients (web, mobile, HR integrations)." {

                // Controllers (entry points)
                cSignIn = component "Sign In Controller" "Allows users to sign in." "REST Controller"
                cResetPwd = component "Reset Password Controller" "Password reset via one-time link." "REST Controller"
                cSummary = component "Learning Summary Controller" "Returns learner/course summaries for dashboards." "REST Controller"

                // Internal components / facades
                compSecurity = component "Security Component" "Sign-in, token validation, RBAC checks." "Component"
                compEmail = component "E-mail Component" "Sends e-mails (verification, reset, reminders)." "Component"
                compLms = component "LMS Facade" "Facade/orchestration to Learning Management Service." "Component"
                compContent = component "Content Facade" "Facade to Content Management Service/CDN." "Component"
                compReports = component "Reporting Facade" "Facade to Analytics & Reporting Service." "Component"
                compCerts = component "Certification Facade" "Facade to Certification Service." "Component"
                compHrSync = component "HR Sync Facade" "Facade to external HR systems." "Component"

                // Clients call controllers
                ctp.wa -> cSignIn "Makes API call (login / refresh token) to" "JSON/HTTPS"
                ctp.ma -> cSignIn "Makes API call (login / refresh token) to" "JSON/HTTPS"
                ctp.wa -> cResetPwd "Makes API call (reset password)" "JSON/HTTPS"
                ctp.wa -> cSummary "Makes API call (fetch dashboard/summary)"
                ctp.ma -> cSummary "Makes API call (fetch dashboard/summary)"

                // Controllers use internal components
                cSignIn -> compSecurity "Validates credentials"
                cResetPwd -> compEmail "Requests password reset email"
                cSummary -> compLms "Fetch enrolments, course progress"
                cSummary -> compContent "Retrieve thumbnails & learning assets"
                cSummary -> compReports "Fetch analytics for dashboard"
                cSummary -> compCerts "Uses (status/badges)"
                compHrSync -> compCerts "Check certificate status/badges"

                // Physical components
                compConceptual = component "Conceptual Data Model (Entities)" "High-level entities & relationships"
                compLogical    = component "Logical Data Model (Normalized Tables)" "Attributes, PK/FK, cardinality"
                compPhysical   = component "Physical Data Model (DDL)" "SQL tables, indexes, constra"

            }

            authsvc = container "Authentication & Authorization Service" "Handles user authentication, SSO, and role-based access control." 
            lms = container "Learning Management Service" "Manages courses, enrolments, progress tracking, and adaptive learning." 
            content = container "Content Management Service" "Stores and serves training materials, videos, and documents."
            ana = container "Analytics & Reporting Service" "Generates dashboards, learner progress, and course effectiveness reports." 
            certsvc = container "Certification Service" "Generates and stores digital certificates for completed courses." 
            db = Data "Database" "Stores user accounts, course data, progress, analytics results, certificates." 
            datalake = Data "Data Lake (Object Storage)" "Raw and curated datasets stored in object storage. Serves as landing zone for ELT and analytics."
            streaming = container "Event Streaming (Kafka/Kinesis)" "Publishes and processes learner interaction events for real-time analytics and adaptive learning." 
            elt = container "ELT Process" "Extracts and loads raw data into the lake, then performs transformations within the warehouse for analytics."
            dw  = Data "Data Warehouse" "Curated analytics layer (star schemas, aggregates)."
            backup = container "Backup/Archive Store" "Encrypted snapshots & long-term retention."            
        }

        /* External Systems */
        hrs = softwareSystem "HR System" "Synchronises employee training and development data."{
            tags "ExternalEntity"
        }
        vs = softwareSystem "Video Streaming Service / CDN" "Delivers scalable video content."{
            tags "ExternalEntity"
        }
        idp = softwareSystem "Authentication Provider (SSO / Identity Provider)" "Provides enterprise SSO / identity management."{
            tags "ExternalEntity"
        }
        pay = softwareSystem "Payment Gateway" "Handles billing and subscription renewals."{
            tags "ExternalEntity"
        }
        mail = softwareSystem "Email / Notification Service" "Sends notifications, reminders, and certificates."{
            tags "ExternalEntity"
        }
        // Physical
        bi = softwareSystem "Analytics & BI Platform" "External dashboards & ad-hoc analysis."{
            tags "ExternalEntity"
        }

               
        /*
        SYSTEM CONTEXT
        */
        
        /* Relationships */
        le -> ctp "Uses the platform to complete training and receive certificates"
        cc -> ctp "Use dashboards, assign training, integrate data with HR systems"
        pa -> ctp "Maintain system, manage accounts, monitor usage."
        ci -> ctp "Uploads/manages training content, reviews feedback and analytics"
        it -> ctp "Provides support and troubleshooting, and ensure uptime."

        /* External System Relationships*/
        ctp -> hrs "Synchronises training and employee data"
        ctp -> vs "Streams training videos"
        ctp -> idp "Uses for secure login"
        ctp -> pay "Handles billing and subscriptions"
        ctp -> mail "Sends notifications, reminders, and certificates"
        ctp -> bi "Publishes curated datasets for reporting"


        /*
        CONTAINER
        */

        /* Relationships, Users -> Containers */
        le -> ctp.wa "Uses for training"
        le -> ctp.ma "Uses for mobile learning"
        cc -> ctp.wa "Manages employees and courses"
        pa -> ctp.wa "Manages users and content"
        ci -> ctp.wa "Creates and manages training content"
        it -> ctp.wa "Provides technical support"

        /* Relationships, Containers -> Containers */
        ctp.wa -> ctp.api "Sends requests via REST/GraphQL"
        ctp.ma -> ctp.api "Sends requests via REST/GraphQL"

        ctp.api -> ctp.authsvc "Authenticates requests"
        ctp.api -> ctp.lms "Manages enrolments, progress"
        ctp.api -> ctp.content "Accesses training materials"
        ctp.api -> ctp.ana "Fetches reports and dashboards"        
        ctp.api -> ctp.certsvc "Requests certificates"
        ctp.api -> ctp.streaming "Publishes learner interaction events (video_play, quiz_submission, progress_update)" 

        ctp.lms -> ctp.db "Stores learner/course data"

        ctp.ana -> ctp.db "Reads learner data"
        ctp.ana -> ctp.dw "Queries curated data models for dashboards and reporting"

        ctp.certsvc -> ctp.db "Stores certificates"
        ctp.certsvc -> ctp.datalake "Stores certificate PDFs (signed, time-limited URLs)"
        
        ctp.db -> ctp.elt "Feeds operational data (batch/CDC) to"
        ctp.db -> ctp.backup "Backups (PITR/snapshots) to"        
        
        ctp.dw -> bi "Serves curated datasets to"        
        ctp.dw -> ctp.backup "Daily warehouse snapshots to"

        ctp.streaming -> ctp.datalake "Writes events as raw files in real-time"

        ctp.elt -> ctp.datalake "Stores raw exports and staging"
        ctp.elt -> ctp.streaming "Consumes event streams (near-real-time ETL)"
        ctp.elt -> ctp.dw "Transforms and loads structured data for analytics"

        ctp.content -> ctp.datalake "Uploads original video assets and retrieves signed URLs"

        /* Relationships, Containers -> External Systems */
        ctp.api -> hrs "Synchronises employee training data"
        ctp.content -> vs "Streams video content"
        ctp.authsvc -> idp "Delegates authentication"
        ctp.api -> pay "Processes billing"
        ctp.api -> mail "Sends notifications"
        vs -> ctp.datalake "Pulls video chunks / manifests (origin fetch)"

        /*
        COMPONENT
        */

        # Security component -> Auth provider (grey)
        ctp.api.compSecurity -> idp "Uses"
        # Email component -> email/notif service (grey)
        ctp.api.compEmail -> mail "Uses"
        # Content facade -> Content management service
        ctp.api.compContent -> ctp.content "Uses"
        # Reporting facade -> analytics and reporting service
        ctp.api.compReports -> ctp.ana "Uses"
        # LMS facade -> learning management service
        ctp.api.compLms -> ctp.lms "Uses"
        # Certification facade -> certification service
        ctp.api.compCerts -> ctp.certsvc "Uses"
        # HR sync facade -> Hr system (grey)
        ctp.api.compHrSync -> hrs "Uses"

        // Physical
        ctp.api.compConceptual -> ctp.api.compLogical "Refines entities to normalized tables"
        ctp.api.compLogical    -> ctp.db              "Informs OLTP schema design"
        ctp.api.compPhysical   -> ctp.db              "Implements SQL DDL (PKs/FKs, indexes)"

    }

    views {
        systemContext ctp "TrainingPlatformContext" {
            include *
            autolayout tb
        }

        container ctp "TrainingPlatformContainers" {
            include *
            autolayout tb
        }

        component ctp.api "BackendAPIComponent" {
            include *
            autolayout tb
        }
        
        component ctp.elt "ELTComponent" {
            include *
            autolayout tb
        }

        styles {
            element "Element" {
                color #ffffff
                stroke #0b86c9
                background #0b86c9
                strokeWidth 7
                shape box
            }
            element "Container" {
                stroke #3875b3
                background #438dd5
                color #ffffff
                shape RoundedBox
            }
            element "Person" {
                shape person
                color #ffffff
                stroke #0b539c
                background #0b539c                
            }
            element "Database" {
                shape cylinder
            }
            element "Mobile" {
                shape MobileDevicePortrait
            }
            element "Web" {
                shape WebBrowser
            }            
            element "Boundary" {
                strokeWidth 5
            }
            element "ExternalEntity" {
                color #ffffff
                stroke #adadad
                background #adadad
                strokeWidth 5
                shape box
            }
            relationship "Relationship" {
                thickness 4
            }
        }
    }
    configuration {
        scope softwaresystem
    }
}
