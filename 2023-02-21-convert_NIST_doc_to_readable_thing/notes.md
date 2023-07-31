# NIST SSDF Distilled

## Abstract

NIST's Secure Software Development Framework is illegible.
I wrote a script that fixes that.  Then I read through it and figured
lots of people could benefit from the work, and a summary.  I include
advice for getting started that aligns with the SSDF.

If you're a big shop or a small shop and you want to tighten the
security in your Software Development system, and the NIST SSDF
was overly difficult to get through, then this talk is for you.

## Intro

[//]: # (TODO: Change presentation link)

This presentation can be found [here](https://github.com/mvanwinkleias/blog_posts/)

### Why This Presentation

* I can't read the [NIST SP 800-218 document](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-218.pdf)
* I can't read the [corresponding spreadsheet](https://csrc.nist.gov/csrc/media/Publications/sp/800-218/final/documents/NIST.SP.800-218.SSDF-table.xlsx).

> I can't read the NIST SSDF document or the spreadsheet.
> It's not provided in a good format.

#### I CAN Read These:

* [Practices Only](https://github.com/mvanwinkleias/blog_posts/blob/master/2023-02-21-convert_NIST_doc_to_readable_thing/NIST.SP.800-218.SSDF-table-practices_only.md)
* [Entire thing in Markdown](https://github.com/mvanwinkleias/blog_posts/blob/master/2023-02-21-convert_NIST_doc_to_readable_thing/NIST.SP.800-218.SSDF-table.md)

#### Audience

People who program.  The SSDF is something EVERYBODY who interacts with
source code should keep in mind.

I recommend you read through a "textual" version of the SSDF.

> Saying this presentation is for "programmers" might leave people out.
> If you write any code that is used at your organization that might
> be reused, and you don't put your code in a revision control system
> please at least stay through the section on Source Repositories
> / Revision Control.

### About Me

* Administrator / Programmer

> I've worked in various programming and adminstrative positions
> at VOIP companies, colleges and laboratories.
>
> I'd like to think my software development practices are secure,
> and I was interested in reconciling them with the SSDF.

* I work at a relatively small place and I've worked at big places.
* I've seen how things scale and not scale.
* I like applying techniques and processes that help get things done.

* I know that resources are always going to be constrained.
* I want people to beneficially level up.

## Disclaimer

* This presentation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

## From the Ground Up...

> Dedicate 5 minutes to list specific / actionable tools / skills

[//]: # (Everything should have a link or something to search for, but preferably a link)
 
> All of this advice relates to the SSDF.

If you're just starting out, here's what I would focus on.

All of these tidbits of information end up relating to the SSDF
(Secure Software Development Framework).


<<<<<<< HEAD
### Projects in Revision Control

> I had to stop myself from turning this into a git tutorial.
> The ability to effectively use revision control is paramount.
=======
### Revision control systems / projects
>>>>>>> 626502048a00a9dedc716d523dd40e5a078a55f1

Learn basic git interaction.  You don't need to be a wizzard.

> Single biggest hurdle to your advancement as a programmer is revision control
> Learn basic git interaction.  It's ubiquitous now.  You should be able to
> clone, add, commit, push, pull, tag.
> You don't need to be a wizzard.

<<<<<<< HEAD
#### Put your code in a repo
=======
#### Don't commit credentials / sensitive information

Learn how to refer to credentials that are located outside
of the project directory.

#### Put your code in a revision control system
>>>>>>> 626502048a00a9dedc716d523dd40e5a078a55f1

* Can be hosted on a forge (gitlab, github)
* Can be hosted locally 

> Put your code in a revision control system.
> If you don't know how to do this locally then...

#### Get a Private Forge Account

Learning basic interaction with these services is crucial:

* github.com
* gitlab.com

> Get a private forge account.  Gitlab and github are 2 popular options.

#### Use It Securely

* Use a secure passphrase, 2FA for your account
* Use separate ssh keys for separate machines
* Manage permissions appropriately

> Secure it with a good passphrase.  Strongly consider 2FA.
> Use different SSH keys for different machines
> Make sure you understand permissions and how to manage them.

#### Start off organized!

Use
 
* a good project layout.  [Repo Layout Demo](https://github.com/mvanwinkleias/repo_layout_demo1)
* a good .gitignore

```
project_1/
├── doc
│   └── index.md
├── Makefile
├── README.md
└── src
    └── bin
        └── project-1.sh
```

Good project layouts help you write modular code.

#### Don't commit credentials / sensitive information

* Keep credentials away!!!

* Learn how to refer to credentials that are located outside
of the source repository.

[Example Code](https://github.com/mvanwinkleias/repo_layout_demo1/tree/master/src/snippits/load_credentials_from_json_file_in_home_directory)

#### Back It Up

Keep archived copies of your software.

* [List git repos in this directory](https://github.com/mvanwinkleias/mv_git_repo_utils/blob/master/src/bin/git_repos_in_this_dir.sh)
* [Git Puller](https://github.com/mvanwinkleias/mv_git_repo_utils/blob/master/src/bin/git_puller.sh) - Just cd's to something and pulls

> Cron up a script that runs git pull, or whatever.  Back that up.


### Coding Practices

These relate to the SSDF.

#### Fail Safely

#### Sanitize Inputs

This is always taken in context.  If it's a non-critical program that
will only be run by trusted people, then you're requirements for
sanitizing inputs can be more relaxed.

If it's a critical process or it might be run by untrusted people
then do the best you can at this.

#### Use Inputs Securely.  Make Mistakes hard to make.

This is different from sanitizing inputs.
A clean bullet in a clean gun can still do bad things.

#### Use the Principle of least privilege

Only give / allow permission to do what's needed.

#### Make "doing the right" thing easy.

* Wrapper scripts -> Automation and Testing
* Documentation / Examples

#### Don't make doing the right thing difficult.

If, when you're writing software, your actions prevent or make following
"good advice" difficult, then you're doing something wrong.

# SSDF Notes:

## PO: Prepare the Organization

### PO.1: Make the Organization aware.

Create, maintain, and communicate the policy and requirements for:

* Software development infrastructure
* Organization-developed software

### PO.2: Take leadership

* Prepare, assign, delegate, etc.
* Obtain commitment from management.

### PO.3: Reduce repeat work and Document

* Use project template systems. i.e. [Cookiecutter](https://cookiecutter.readthedocs.io/en/stable/)
* Use automation.  (I have a rant about this...)
	* Have an audit trail

### PO.4: Perform Software Security Audits.

Example:

* OWASP Application Security Verification Standard
	* https://owasp.org/www-project-application-security-verification-standard/

### PO.5 Implement, Maintain, and Secure Your environments.

Make the environment.

## PS: Protect the Software

### PS.1: Protect All Forms of Code from Unauthorized Access and Tampering

Taken straight from the practice name.

### PS.2: Make verification easy

### PS.3: Archive and Protect Each Software Release

* Backup your artifacts.  (Make sure you're backing up your code too...)
* Sign / hash your artifacts.
* Have an audit trail

## PW: Produce Well-Secured Software

Make the software.

### PW.1: Design Software to Meet Security Requirements and Mitigate Security Risks

* Use what you did for P0.3 (Reduce repeat work and document).
* Reconcile
* Integrate with existing infrastructure (logging, IAM, etc)

### PW.2: Audit and Review

* Reconcile with PO.4 (Perform Security audits).
* Code Reviews

### PW.4: Do What PO.3 (Reduce repeat work) Says.

* Reuse and improve the good stuff
* During the process of producing code, reconcile common actions with
templates.
* Audit other people's stuff

### PW.5: Follow Best Practices for Creating Secure Code

### PW.6: Enable warnings!

Get stuff to tell you what's wrong while you're making software.

### PW.7: Do code reviews

### PW.8: Test the product

But like, for "security".

### Pw.9: Default Settings Should Be Secure

## RV: Respond to Vulnerabilities

This is just good vulnerability management.

One slide.

### RV.1: Identify and Confirm Vulnerabilities

### RV.2: Assess, Prioritize, and Remediate Vulnerabilities

### RV.3: Analyze Vulnerabilities to Identify Their Root Causes
