# Contributing

When contributing to OCPI, please first discuss the change you wish to make via issue,
email, slack, or any other method with the OCPI community.

Please note we have a code of conduct, please follow it in all your interactions with the project.


## Adding new features/functionality
We strive to keep OCPI as free from IPR as possible. If you want to contribute by adding new functionality/features, 
you are required to send us the signed Contributor License Agreement (CLA) document before contributing.
To get the CLA, ask for it by send an e-mail to: [ocpi@nklnederland.nl](MAILTO:ocpi@nklnederland.nl).

If you have send us the signed CLA, create a feature branch, 
branching off from the development branch: `develop`

Effort should be made to assure backward compatibility. If this is not possible, this should always be
explicitly mentioned and provide upgrade path

New modules should be designed to be used independently from other (existing) modules, when possible.

New functionality/modules will take into account security and privacy.


## Fixing bugs/typos
Anybody (also without a signed Contributor License Agreement (CLA)) is welcome to fix an editorial issue, typo, improve example etc. 
Please use Pull Requests for this.
When fixing something in an existing version of OCPI, use the correct bug fix branch, for example: `release-2.2-bugfixes`.


## Pull Request Process

1. Ensure you have branched off (or forked) from the correct branch (e.g. `release-2.2-bugfixes`), NEVER use `master`.
2. Make your changes.
3. Create a pull request to the correct branch.
4. One of the core team members will review your pull request.
5. When the core team member accept the pull request, he/she will merge the Pull Request.


## OCPI Specification release process

If new functionality makes it into a new release is decided via a voting-procedure of companies/persons that signed the CLA.
Request of a new functionality will be approved by a majority of at least 70% of the OCPI community who signed
the CLA and took part in the voting-procedure.

Request of a specific feature, to be used only in a specific context (i.e. for hubs, a specific region or country)
will be approved by a minimum of 25% of the voters of OCPI community who signed the CLA and took part
in the voting-procedure

Releasing OCPI specifications shall only be done by the maintainers.

All the development of a new OCPI version is done on the `develop` branch.
We try to use feature branches as much as possible.

When the OCPI community want to release a new OCPI version, this will be released from the `develop` branch.

The new release will be merged into `master`. This way we ensure that `master` always contains the latest release. 

At that moment also a new `release-*.*-bugfixes` branch will be created, which is to be used for fixing bugs/issues in the release version.
The README.md will be update to point to this bug fix branch. 


### OCPI Version numbering

OCPI follows the following numbering scheme: `major.minor[.maintenance]`


### OCPI Specification fix releases

We always hope we never have to do this, but it might happen that we have to release a fixed version of OCPI, 
because an error has slipped into the OCPI messages that cannot be fixed with documentation update only.
In such a cause we will release a maintenance release: `*.*.1` etc, the original version then becomes deprecated, and should no longer be used.
For example: to fix a couple of bugs in `OCPI 2.1`, we had to release `2.1.1`. 

### OCPI Documentation update release process

The OCPI community can decide to release an updated version of an OCPI protocol version. 
For example: `2.0-d2` which contains a number of fixes in the documentation of `OCPI 2.0`, but no changes in the protocol.
 

## Custom modules

Any OCPI implementation is allowed to implement custom modules as specified by the documentation.

If a company/contributor wants such a custom module to become part of a future version of OCPI 
they have to create a pull request for new functionality as described above. 
For this you also need to have signed the CLA.

This new module has to go through the voting process.


## Code of Conduct

### Our Pledge

In the interest of fostering an open and welcoming environment, we as
contributors and maintainers pledge to making participation in our project and
our community a harassment-free experience for everyone, regardless of age, body
size, disability, ethnicity, gender identity and expression, level of experience,
nationality, personal appearance, race, religion, or sexual identity and
orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment
include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attention or
advances
* Trolling, insulting/derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or electronic
  address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

### Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable
behavior and are expected to take appropriate and fair corrective action in
response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other contributions
that are not aligned to this Code of Conduct, or to ban temporarily or
permanently any contributor for other behaviors that they deem inappropriate,
threatening, offensive, or harmful.

### Scope

This Code of Conduct applies both within project spaces and in public spaces
when an individual is representing the project or its community. Examples of
representing a project or community include using an official project e-mail
address, posting via an official social media account, or acting as an appointed
representative at an online or offline event. Representation of a project may be
further defined and clarified by project maintainers.

### Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be
reported by contacting the project team at [ocpi@nklnederland.nl](MAILTO:ocpi@nklnederland.nl). 
All complaints will be reviewed and investigated and will result in a response that
is deemed necessary and appropriate to the circumstances. The project team is
obligated to maintain confidentiality with regard to the reporter of an incident.
Further details of specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct in good
faith may face temporary or permanent repercussions as determined by other
members of the project's leadership.

### Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
available at [http://contributor-covenant.org/version/1/4][version]

[homepage]: http://contributor-covenant.org
[version]: http://contributor-covenant.org/version/1/4/
