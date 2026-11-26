# Open Charge Point Interface (OCPI)

This repository holds the OCPI specification, developed by the [EV Roaming Foundation](https://evroaming.org/).

## Versions

| Version | Current release | Branch |
|---|---|---|
| [OCPI 2.3.0](#ocpi-230) | 2.3.0-ed2, of 2026-06-18 | [`2.3.0/core`](https://github.com/ocpi/ocpi/tree/2.3.0/core) |
| [OCPI 2.2.1](#ocpi-221) | 2.2.1-d2, of 2023-09-07 | [`release-2.2.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.2.1-bugfixes) |
| [OCPI 2.1.1](#ocpi-211) | 2.1.1-d2, of 2019-06-21 | [`release-2.1.1-bugfixes`](https://github.com/ocpi/ocpi/tree/release-2.1.1-bugfixes) |

Implement from the current release of a version. A correction is proposed as a pull request against the branch of its
version; see [CONTRIBUTING.md](CONTRIBUTING.md).

## OCPI 2.3.0

The current version. The specification includes the Payments module, and since edition 2 the Invoice Reconciliation
module. The sources are the `.asciidoc` files in the root of branch `2.3.0/core`.

| Release | Date | What it is |
|---|---|---|
| OCPI 2.3.0-ed3 | Not released | Edition 3, in preparation on branch `2.3.0/core`: corrections made after edition 2. |
| [OCPI 2.3.0-ed2](https://github.com/ocpi/ocpi/releases/tag/2.3.0-ed2) | 2026-06-18 | Edition 2: corrections and the Invoice Reconciliation module. The text submitted to CEN-CENELEC. |
| [OCPI 2.3.0](https://github.com/ocpi/ocpi/releases/tag/v2.3.0) | 2025-02-21 | The original release. |

## OCPI 2.2.1

The version before 2.3.0. The sources are the `.asciidoc` files in the root of branch `release-2.2.1-bugfixes`.

| Release | Date | What it is |
|---|---|---|
| OCPI 2.2.1-d3 | Not released | Documentation update 3, in preparation on branch `release-2.2.1-bugfixes`. |
| [OCPI 2.2.1-d2](https://github.com/ocpi/ocpi/tree/v2.2.1-d2) | 2023-09-07 | Documentation update 2. Published as a tag, without a GitHub Release. |
| [OCPI 2.2.1](https://github.com/ocpi/ocpi/releases/tag/2.2.1) | 2021-10-06 | The original release. |

## OCPI 2.1.1

The sources are the `.md` files in the root of branch `release-2.1.1-bugfixes`.

| Release | Date | What it is |
|---|---|---|
| OCPI 2.1.1-d3 | Not released | Documentation update 3, in preparation on branch `release-2.1.1-bugfixes`. |
| [OCPI 2.1.1-d2](https://github.com/ocpi/ocpi/releases/tag/2.1.1-d2) | 2019-06-21 | Documentation update 2. |
| [OCPI 2.1.1](https://github.com/ocpi/ocpi/releases/tag/2.1.1) | 2017-06-08 | The original release. |

## Version names, tags, releases and branches

### Version names

| Name | Example | Meaning |
|---|---|---|
| Version | `2.3.0` | A version of the protocol. Platforms negotiate on this number. |
| Documentation update | `2.2.1-d2` | The same protocol version with clearer text and corrected examples. Used up to OCPI 2.2.1. |
| Edition | `2.3.0-ed2` | The same protocol version with corrections. Used from OCPI 2.3.0. |
| Release candidate | `2.3.0-ed3-rc1` | A build for review. Never implement from a release candidate. |

### Tags and releases

- A release is a tag on the branch of its version. The tag has the name of the document built from it, such as
  `2.3.0-ed2`.
- The document version in `releases/Makefile` and `pdf_layout.asciidoc` equals the tag name at the tagged commit.
- For OCPI 2.3.0, a pushed tag whose name starts with `2.3.0` builds the PDF and creates the GitHub Release.
- A published tag is never moved or deleted. A correction to a released document is a new edition.
- A release that is replaced stays available. Its title starts with "[SUPERSEDED]" and its description names the
  release that replaces it.
- A release candidate is built from the branch for review. It gets no tag and no GitHub Release.

### Branches

- Every version has one branch, named in the table under [Versions](#versions). The sources and all releases of that
  version are on that branch.
- A change reaches the branch as a pull request; see [CONTRIBUTING.md](CONTRIBUTING.md).
- Changes for the next release of a version collect on its branch until that release is tagged.
- There is no separate branch per module or per release.

For OCPI 2.3.0, a change is made on a short-lived branch, created from `2.3.0/core`, of one of two kinds:

| Kind | Branch name | Use it for |
|---|---|---|
| Hotfix | `2.3.0/hotfix/<short-name>` | A correction to the released text: an error, an unclear sentence, a wrong example. |
| Feature | `2.3.0/feature/<short-name>` | An addition that keeps 2.3.0 platforms compatible, such as a new optional field or a new module. |
