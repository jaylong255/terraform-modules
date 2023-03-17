## ======= READ AND DELETE =====

Hellur. Welcome to opening a pull request, yo. Thank you for contributing! (probably)
Review the checklist and do as commanded. If you have questions ask the
[code owners](https://github.com/jaylong255/terraform-modules/blob/master/.github/CODEOWNERS)
Shout-out to Ferris at Urban Dynamics for this tempalate format. I totally ripped this from
one of his.

### About PR reviews

PRs are viewed as follows:

1. Open PRs are considered ready for full review and merge.
2. We highly recommend starting with a draft so we can collaborate and have discussions as work 
is being done. It's not required but certainly recommended.

Make small PRS, not large ones. If your PR is getting long, try to break it apart into two.

If you absolutely have to make a big one, make your commits clean.

Don't hesitate to set up a meeting with the code owners if it feels like we're stuck going back 
and forth for too long.

## ==== DELETE THE ABOVE ====

## Ticket(s)

1. [CYB-0000: TICKET NAME](https://cyberworld.atlassian.net/browse/CYB-0000)

## Related PR(s)

1. [#0](https://github.com/jaylong255/terraform-modules/pull/0)

## Changes

1. Add X in `src/foo.ts`
2. Standardize Y in `src/bar.ts`
3. ...

## Checklist

- [ ] **PR Name:** Please name this PR in format of
      `[TICKET_ID]: [BRIEF DESCRIPTION]`. For example: _MONO-0000: Implement
      component X to use with Y_
- [ ] **Ticket(s) and Related PR(s):** Add the tickets that this PR will resolve
      once merge. You can also add a list of related PR(s); this is useful when
      to communicate that another PR must be reviewed first.
- [ ] **Change Description:** Please update the above change list to provide a
      list of changes done. This will be added to the commit when merged for a
      useful commit description.
  - This can be omitted in the rare case that the PR is very small and the title
    alone clearly explains what it does.
- [ ] **Tests:** All code should have strong tests. If you have questions about
      this please ask one of the code owners. All tests need to pass CI for all
      test matrix combinations for your PR to be considered for merge.
- [ ] **Code Owner Review:** Please add at least one repository code owner as a
      reviewer. You are welcome to add anyone else you'd like feedback from.
- [ ] **Squash Commit with Details:** It's hard to keep a perfect commit record
      so we prefer squash commits. When doing squash commits the commit name
      should auto fill the the PR name (formatted as defined in the **PR Name**
      section above) plus `(#123)` where the number is the PR number. Set the
      commit paragraph text to be the changes list above (don't include
      "Changes" header, just the list).