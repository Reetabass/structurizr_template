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

            // === Backend API (expanded with components; L2 semantics unchanged) ===
            api = container "Backend API" "Provides APIs for clients (web, mobile, HR integrations)." {

                // ---- Controllers (entry points) ----
                cSignIn   = component "Sign In Controller" "Allows users to sign in." "REST Controller"
                cResetPwd = component "Reset Password Controller" "Password reset via one-time link." "REST Controller"
                cSummary  = component "Learning Summary Controller" "Returns learner/course summaries for dashboards." "REST Controller"

                // ---- Internal components / facades ----
                compSecurity = component "Security Component" "Sign-in, token validation, RBAC checks." "Component"
                compEmail    = component "E-mail Component" "Sends e-mails (verification, reset, reminders)." "Component"
                compLms      = component "LMS Facade" "Facade/orchestration to Learning Management Service." "Component"
                compContent  = component "Content Facade" "Facade to Content Management Service/CDN." "Component"
                compReports  = component "Reporting Facade" "Facade to Analytics & Reporting Service." "Component"
                compCerts    = component "Certification Facade" "Facade to Certification Service." "Component"
                compHrSync   = component "HR Sync Facade" "Facade to external HR systems." "Component"

                // ---- Clients call controllers (for L3 view context) ----
                ctp.wa -> cSignIn   "Makes API call (login / refresh token) to" "JSON/HTTPS"
                ctp.ma -> cSignIn   "Makes API call (login / refresh token)"
                ctp.wa -> cResetPwd "Makes API call (reset password)" "JSON/HTTPS"
                ctp.wa -> cSummary  "Makes API call (fetch dashboard/summary)"
                ctp.ma -> cSummary  "Makes API call (fetch dashboard/summary)"

                // ---- Controllers use internal components ----
                cSignIn -> compSecurity "Validates credentials"
                cResetPwd -> compEmail "Requests password reset email"
                cSummary -> compLms "Fetch enrolments, course progress"
                cSummary -> compContent "Retrieve thumbnails & learning assets"
                cSummary -> compReports "Fetch analytics for dashboard"
                cSummary -> compCerts "Uses (status/badges)"
                compHrSync -> compCerts "Check certificate status/badges"
            }

            authsvc = container "Authentication & Authorization Service" "Handles user authentication, SSO, and role-based access control." 
            lms = container "Learning Management Service" "Manages courses, enrolments, progress tracking, and adaptive learning." 
            content = container "Content Management Service" "Stores and serves training materials, videos, and documents."
            ana = container "Analytics & Reporting Service" "Generates dashboards, learner progress, and course effectiveness reports." 
            certsvc = container "Certification Service" "Generates and stores digital certificates for completed courses." 
            db = Data "Database" "Stores user accounts, course data, progress, analytics results, certificates." 
            filestore = Data "File Storage" "Stores large media files (videos, documents, certificates)."             
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
        ctp.lms -> ctp.db "Stores learner/course data"
        ctp.content -> ctp.filestore "Stores files and media"
        ctp.ana -> ctp.db "Reads learner data"
        ctp.certsvc -> ctp.db "Stores certificates"
        ctp.certsvc -> ctp.filestore "Stores certificate PDFs"

        /* Relationships, Containers -> External Systems */
        ctp.api -> hrs "Synchronises employee training data"
        ctp.content -> vs "Streams video content"
        ctp.authsvc -> idp "Delegates authentication"
        ctp.api -> pay "Processes billing"
        ctp.api -> mail "Sends notifications"
    }

    views {
        systemContext ctp "TrainingPlatformContext" {
            include *
            autolayout lr
        }

        container ctp "TrainingPlatformContainers" {
            include *
            autolayout lr
        }

        component ctp.api "TrainingPlatformComponent" {
            include *
            autolayout lr
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
