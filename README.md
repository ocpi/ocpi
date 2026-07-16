# Open Charge Point Interface (OCPI)

This repository contains the OCPI specification. The most recent specification is **OCPI 2.3.0**, which is published as
a core document plus separately packaged optional modules.
See [OCPI 2.3.0 releases and branching strategy](#ocpi-230-releases-and-branching-strategy) below for how the documents
and branches relate.

## Branches and releases

### Latest official release

The latest official release is **OCPI 2.3.0**, published across the [
`2.3.0/release/*`](https://github.com/ocpi/ocpi/branches/all?query=2.3.0%2Frelease) branches, with [
`2.3.0/release/core`](https://github.com/ocpi/ocpi/tree/2.3.0/release/core) as the core specification. Development of
the next version of OCPI (new functionality) is done in the [ocpi-3 repository](https://github.com/ocpi/ocpi-3/), which
is only accessible to Contributors of the [EV Roaming Foundation](https://evroaming.org/how-to-join/).

> The `2.3.0/release/*` branches replace `master` as the reference for the current release.

### Bugfix branches for OCPI 2.2.1, OCPI 2.2, and OCPI 2.1.1

Fixes to earlier documentation live on dedicated bugfix branches:

- [`release-2.2.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.2.1-bugfixes) — latest fixes to the 2.2.1
  documentation
- [`release-2.2-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.2-bugfixes) — latest fixes to the 2.2
  documentation
- [`release-2.1.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.1.1-bugfixes) — latest fixes to the 2.1.1
  documentation

## OCPI 2.3.0 releases and branching strategy

OCPI 2.3.0 is published as a **core specification** together with several **functional modules** that are packaged and
released independently. This section explains how the branches, documents, and versions relate.

### 2.3.0 branches

The 2.3.0 work is organized into three kinds of branches under the shared `2.3.0/` namespace: **release** branches (
published sources of truth), **feature** branches (work in progress), and **hotfix** branches (corrections to a
published release).

#### Releases

Release branches hold the published sources of truth — the core specification and each module.

| Branch                                                                               | Contents               | Role                                  |
|--------------------------------------------------------------------------------------|------------------------|---------------------------------------|
| [`2.3.0/release/core`](https://github.com/ocpi/ocpi/tree/2.3.0/release/core)         | Core specification     | **Source of truth for the core spec** |
| [`2.3.0/release/payments`](https://github.com/ocpi/ocpi/tree/2.3.0/release/payments) | Core + Payments module | Source of truth for Payments          |
| [`2.3.0/release/bookings`](https://github.com/ocpi/ocpi/tree/2.3.0/release/bookings) | Core + Bookings module | Source of truth for Bookings          |

#### Features

Feature branches hold work in progress. Once a module or change is ready, it is merged into the relevant release branch
and the feature branch is archived.

| Branch            | Contents                         | Role                                        |
|-------------------|----------------------------------|---------------------------------------------|
| `2.3.0/feature/*` | Modules or changes being drafted | Merged into a release branch, then archived |

#### Hotfixes

Hotfix branches collect corrections to an already-published release. As with feature branches, the fixes are merged into
the relevant release branch and the hotfix branch is then archived.

| Branch           | Contents                                          | Role                                        |
|------------------|---------------------------------------------------|---------------------------------------------|
| `2.3.0/hotfix/*` | Corrections being drafted for a published release | Merged into a release branch, then archived |

> `release-2.3.0-bugfixes` predates the `2.3.0/release/*` convention. It holds edition 1 and is now frozen: all of its
> fixes have been carried into `2.3.0/release/core`. New work and new implementations should follow the `2.3.0/release/*`
> branches.

### Versioning of the 2.3.0 documents

OCPI releases use a semantic-style version number of the form `MAJOR.MINOR.PATCH` (for example `2.0`, `2.1.1`, `2.2`,
`2.2.1`). Any change to the specification produces a new number: a larger increment signals a broader or breaking
change, a smaller one a minor or corrective change. Documentation revisions of the *same* specification are marked with
a `-dN` suffix (for example `2.1.1-d2`, `2.2-d2`), indicating updated text and examples with no protocol change.

> **Note — versioning methodology under discussion.**
> One proposal is to adopt the CEN-CENELEC versioning methodology: the protocol version stays fixed, and changes are
> expressed through multiple levels; for example, an **edition** (`ed2`) for changes to messages, fields, or datatypes,
> and a **documentation update** (`-d2`) for text and examples only. The same methodology could also be applied to modules
> so that each module carries its own edition and evolves independently of the core.

### Compatibility matrix

| Document (PDF)                        | GitHub tag                | GitHub branch            | Core | Modules      | Remarks                                                                                             | Status           |
|---------------------------------------|---------------------------|--------------------------|------|--------------|-----------------------------------------------------------------------------------------------------|------------------|
| OCPI 2.3.0 (including Payments)       | `v2.3.0`                  | `release-2.3.0-bugfixes` | 1    | Payments 1   | The `release-2.3.0-bugfixes` branch will be deleted                                                 | Released         |
| OCPI 2.3.0 Edition 1                  | `v2.3.0-ed1`              | `2.3.0/release/core`     | 1    | -            | Similar to OCPI 2.3.0 without the payment module                                                    | Internal Release |
| **OCPI 2.3.0 Edition 2**              | `v2.3.0-ed2`              | `2.3.0/release/core`     | 2    | -            | Core improvements and Invoice Reconciliation                                                        | Planned          |
| OCPI 2.3.0 Payments                   | `v2.3.0-payments`         | `2.3.0/release/payments` | 1    | Payments 1   | Exactly the same specification as OCPI 2.3.0 (including Payments)                                   | -                |
| **OCPI 2.3.0 Edition 2 Payments**     | `v2.3.0-ed2-payments`     | `2.3.0/release/payments` | 2    | Payments 1   | Core changes are applied to the payment document. No changes to the Payment module. To be certified | Planned          |
| OCPI 2.3.0 Bookings                   | -                         | `develop-2.3.0-booking`  | 1    | Bookings 1   | The `develop-2.3.0-booking` branch will be deleted                                                  | Released         |
| OCPI 2.3.0 Bookings 1.1               | -                         | `develop-2.3.0-booking`  | 1    | Bookings 1.1 | The `develop-2.3.0-booking` branch will be deleted                                                  | Released         |
| OCPI 2.3.0 Bookings                   | `v2.3.0-bookings`         | `2.3.0/release/bookings` | 1    | Bookings 1   | Exactly the same specification as `OCPI 2.3.0 Bookings`                                             | -                |
| OCPI 2.3.0 Bookings 1.1               | `v2.3.0-bookings-ed2`     | `2.3.0/release/bookings` | 1    | Bookings 1.1 | Exactly the same specification as `OCPI 2.3.0 Bookings 1.1`                                         | -                |
| **OCPI 2.3.0 Edition 2 Bookings 1.1** | `v2.3.0-ed2-bookings-ed2` | `2.3.0/release/bookings` | 2    | Bookings 1.1 | Both core changes and booking changes are applied.                                                  | Planned          |

> **Notes**
> - None of the 2.3.0 tags are published as GitHub *Releases* — they exist only as git tags.
> - The current Bookings source of truth (Booking 1.1) is **not yet tagged**; the `v2.3.0-bookings` tag still points at Booking 1.0.
> - `2.3.0/release/bookings` branches from the core lineage *before* edition 2, so it does not yet include the edition 2 core fixes or the Invoice Reconciliation module. Rebasing the module branches onto `2.3.0/release/core` would align every package on the same core edition.
> - Two edition-1 baseline tags exist for the restructured branches — `v2.3.0-ed1` and `v2.3.0-edition1` (the latter is orphaned, on no branch). They do not correspond to a separate published document and should be consolidated.

## Specification contents

- [__Version History__](version_history.asciidoc)
- [__Introduction__](introduction.asciidoc)
    - [Terminology and Definitions](terminology.asciidoc)
    - [Supported Topologies](topology.asciidoc)
- __Protocol Meta Information__ — describes the connections between the parties
    - [Transport and Format](transport_and_format.asciidoc)
    - [Status codes](status_codes.asciidoc)
    - [Version information endpoint](version_information_endpoint.asciidoc)
    - [Credentials & registration](credentials.asciidoc)
- __Overview of Modules__ — each section describes one module
    - [Locations](mod_locations.asciidoc)
    - [Sessions](mod_sessions.asciidoc)
    - [CDRs](mod_cdrs.asciidoc)
    - [Tariffs](mod_tariffs.asciidoc)
    - [Tokens](mod_tokens.asciidoc)
    - [Commands](mod_commands.asciidoc)
    - [Charging Profiles](mod_charging_profiles.asciidoc)
    - [Hub Client Info](mod_hub_client_info.asciidoc)
    - [Invoice Reconciliation](mod_invoice_reconciliation.asciidoc) _(added in edition 2)_
- __Generic Types__ — describing all data types that are used by multiple objects
    - [Types](types.asciidoc)
- [__Changelog__](changelog.asciidoc)

Additional Modules

- [Payments](https://github.com/ocpi/ocpi/blob/2.3.0/release/payments/mod_payments.asciidoc)
- [Bookings](https://github.com/ocpi/ocpi/blob/2.3.0/release/bookings/mod_bookings.asciidoc)
