# Component Code Views (Mermaid)

## Sign In Controller

```mermaid
classDiagram
    class SignInController {
        +endpoint(): SignInControllerDTO
    }
    class SignInControllerService {
        +execute(): SignInControllerDTO
    }
    class SignInControllerRepository {
        +save(entity): void
        +find(...): SignInControllerEntity
    }
    class SignInControllerEntity
    class SignInControllerDTO

    SignInController --> SignInControllerService
    SignInControllerService --> SignInControllerRepository
    SignInControllerService ..> SignInControllerDTO
    SignInControllerRepository ..> SignInControllerEntity
```

## Reset Password Controller

```mermaid
classDiagram
    class ResetPasswordController {
        +endpoint(): ResetPasswordControllerDTO
    }
    class ResetPasswordControllerService {
        +execute(): ResetPasswordControllerDTO
    }
    class ResetPasswordControllerRepository {
        +save(entity): void
        +find(...): ResetPasswordControllerEntity
    }
    class ResetPasswordControllerEntity
    class ResetPasswordControllerDTO

    ResetPasswordController --> ResetPasswordControllerService
    ResetPasswordControllerService --> ResetPasswordControllerRepository
    ResetPasswordControllerService ..> ResetPasswordControllerDTO
    ResetPasswordControllerRepository ..> ResetPasswordControllerEntity
```

## Learning Summary Controller

```mermaid
classDiagram
    class LearningSummaryController {
        +endpoint(): LearningSummaryControllerDTO
    }
    class LearningSummaryControllerService {
        +execute(): LearningSummaryControllerDTO
    }
    class LearningSummaryControllerRepository {
        +save(entity): void
        +find(...): LearningSummaryControllerEntity
    }
    class LearningSummaryControllerEntity
    class LearningSummaryControllerDTO

    LearningSummaryController --> LearningSummaryControllerService
    LearningSummaryControllerService --> LearningSummaryControllerRepository
    LearningSummaryControllerService ..> LearningSummaryControllerDTO
    LearningSummaryControllerRepository ..> LearningSummaryControllerEntity
```

## Security Component

```mermaid
classDiagram
    class SecurityComponentController {
        +endpoint(): SecurityComponentDTO
    }
    class SecurityComponentService {
        +execute(): SecurityComponentDTO
    }
    class SecurityComponentRepository {
        +save(entity): void
        +find(...): SecurityComponentEntity
    }
    class SecurityComponentEntity
    class SecurityComponentDTO

    SecurityComponentController --> SecurityComponentService
    SecurityComponentService --> SecurityComponentRepository
    SecurityComponentService ..> SecurityComponentDTO
    SecurityComponentRepository ..> SecurityComponentEntity
```

## E-mail Component

```mermaid
classDiagram
    class EmailComponentController {
        +endpoint(): EmailComponentDTO
    }
    class EmailComponentService {
        +execute(): EmailComponentDTO
    }
    class EmailComponentRepository {
        +save(entity): void
        +find(...): EmailComponentEntity
    }
    class EmailComponentEntity
    class EmailComponentDTO

    EmailComponentController --> EmailComponentService
    EmailComponentService --> EmailComponentRepository
    EmailComponentService ..> EmailComponentDTO
    EmailComponentRepository ..> EmailComponentEntity
```

## LMS Facade

```mermaid
classDiagram
    class LMSFacadeController {
        +endpoint(): LMSFacadeDTO
    }
    class LMSFacadeService {
        +execute(): LMSFacadeDTO
    }
    class LMSFacadeRepository {
        +save(entity): void
        +find(...): LMSFacadeEntity
    }
    class LMSFacadeEntity
    class LMSFacadeDTO

    LMSFacadeController --> LMSFacadeService
    LMSFacadeService --> LMSFacadeRepository
    LMSFacadeService ..> LMSFacadeDTO
    LMSFacadeRepository ..> LMSFacadeEntity
```

## Content Facade

```mermaid
classDiagram
    class ContentFacadeController {
        +endpoint(): ContentFacadeDTO
    }
    class ContentFacadeService {
        +execute(): ContentFacadeDTO
    }
    class ContentFacadeRepository {
        +save(entity): void
        +find(...): ContentFacadeEntity
    }
    class ContentFacadeEntity
    class ContentFacadeDTO

    ContentFacadeController --> ContentFacadeService
    ContentFacadeService --> ContentFacadeRepository
    ContentFacadeService ..> ContentFacadeDTO
    ContentFacadeRepository ..> ContentFacadeEntity
```

## Reporting Facade

```mermaid
classDiagram
    class ReportingFacadeController {
        +endpoint(): ReportingFacadeDTO
    }
    class ReportingFacadeService {
        +execute(): ReportingFacadeDTO
    }
    class ReportingFacade {
        +save(entity): void
        +find(...): ReportingFacadeEntity
    }
    class ReportingFacadeEntity
    class ReportingFacadeDTO

    ReportingFacadeController --> ReportingFacadeService
    ReportingFacadeService --> ReportingFacade
    ReportingFacadeService ..> ReportingFacadeDTO
    ReportingFacade ..> ReportingFacadeEntity
```

## Certification Facade

```mermaid
classDiagram
    class CertificationFacadeController {
        +endpoint(): CertificationFacadeDTO
    }
    class CertificationFacadeService {
        +execute(): CertificationFacadeDTO
    }
    class CertificationFacadeRepository {
        +save(entity): void
        +find(...): CertificationFacadeEntity
    }
    class CertificationFacadeEntity
    class CertificationFacadeDTO

    CertificationFacadeController --> CertificationFacadeService
    CertificationFacadeService --> CertificationFacadeRepository
    CertificationFacadeService ..> CertificationFacadeDTO
    CertificationFacadeRepository ..> CertificationFacadeEntity
```

## HR Sync Facade

```mermaid
classDiagram
    class HRSyncFacadeController {
        +endpoint(): HRSyncFacadeDTO
    }
    class HRSyncFacadeService {
        +execute(): HRSyncFacadeDTO
    }
    class HRSyncFacadeRepository {
        +save(entity): void
        +find(...): HRSyncFacadeEntity
    }
    class HRSyncFacadeEntity
    class HRSyncFacadeDTO

    HRSyncFacadeController --> HRSyncFacadeService
    HRSyncFacadeService --> HRSyncFacadeRepository
    HRSyncFacadeService ..> HRSyncFacadeDTO
    HRSyncFacadeRepository ..> HRSyncFacadeEntity
```
