## Security Requirements for Internal Only Software

If you're just starting out, here's what I would focus on.

## Don't commit credentials / sensitive information

Learn how to refer to credentials that are located outside
of the source repository.

## Sanitize Inputs

This is always taken in context.  If it's a non-critical program that
will only be run by trusted people, then you're requirements for
sanitizing inputs can be more relaxed.

If it's a critical process or it might be run by untrusted people
then do the best you can at this.

## Use Inputs Securely.  Make Mistakes hard to make.

This is different from sanitizing inputs.
A clean bullet in a clean gun can still do bad things.

#### Principle of least privilege

Only give / allow permission to do what's needed.

### Make "doing the right" thing easy.

* Wrapper scripts
* Documentation / Examples

### Don't make doing the right thing difficult.

If, when you're writing software, your actions prevent or make following
"good advice" difficult, then you're doing something wrong.

# Notes

## PO: Prepare the Organization

### PO.1: Make people aware.

### PO.2: Take leadership

Assign, delegate, etc.

### PO.3: Reduce repeat work and Document

* Use project template systems.
* Use automation.

### PO.4:  Perform Software Security Audits.

Example:

* OWASP Application Security Verification Standard
	* https://owasp.org/www-project-application-security-verification-standard/

### PO.5 Implement, Maintain, and Secure Your environments.

Do it.

## PS: Protect the Software

### PS.1: Protect All Forms of Code from Unauthorized Access and Tampering

Taken straight from the practice name.

### PS.2: Make verification easy

### PS.3: Archive and Protect Each Software Release

## PW: Produce Well-Secured Software (PW)

This Practice Group is mainly focused on doing the above correctly.

### PW.1: Design Software to Meet Security Requirements and Mitigate Security Risks

* Use what you did for P0.3 (Reduce repeat work and document).

### PW.2: Audit

* Reconcile with PO.4 (Perform Security audits).

### PW.4: Do What PO.3 (Reduce repeat work) Says.

During the process of producing code, reconcile common actions with
templates.

### PW.5: Follow Best Practices for Secure Code

### PW.6: Enable warnings!

### PW.7: Do code reviews

### PW.8: Test the product

But like, with "security".

### Pw.9: Default Settings Should Be Secure

## RV: Respond to Vulnerabilities

### RV.1: Identify and Confirm Vulnerabilities

### RV.2: Assess, Prioritize, and Remediate Vulnerabilities

### RV.3: RV.3: Analyze Vulnerabilities to Identify Their Root Causes
