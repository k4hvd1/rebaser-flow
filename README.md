# rebaser-flow


# TLDR;

`Resbaser flow` is git flow that uses `rebase` over remote branches as well. 

Instead of having history like:
```mermaid
gitGraph
    branch dev
    commit
    branch qa
    branch prod
    checkout dev
    commit id: "A"
    commit id: "B"
    commit id: "C"
    checkout qa
    merge dev
    checkout prod
    merge qa
    checkout dev
    commit id: "D"
    checkout qa
    commit id: "B-fix"
    checkout dev
    merge qa tag: "fix merge"
    checkout prod
    commit id: "A-hotfix"
    checkout qa
    merge prod tag: "hotfix merge"
    checkout dev
    merge prod tag: "hotfix merge"
    commit id:" "
    checkout qa
    merge dev
    checkout prod
    merge qa
```
It produces history like:
```mermaid
gitGraph
    branch dev
    commit
    branch qa
    branch prod
    checkout dev
    commit id: "A"
    commit id: "B"
    commit id: "C"
    checkout qa
    merge dev
    checkout prod
    merge qa
    checkout prod
    commit id: "A-hotfix"
    checkout qa
    merge prod tag:"hotfix rebased"
    commit id: "B-fix"
    checkout dev
    merge qa tag: "fix rebased"
    commit id: "D"
    checkout qa
    merge dev tag: "upq promoted"
    checkout prod
    merge qa tag: "upprod promoted"
```

It produces history with no conflicts, and instead of having sequence ***D, B-fix, A-hotfix***, the one that exists form ***developer perspective***, it produces ***A-hotfix, B-fix, D*** which exist from ***deployment perspective***.

History comparison
|A,B,C,B-fix,A-hotfix|A,A-hotfix,B,B-fix,C|
|-|-|
|Dev chronological|Deployment chronological|
| |Functionally logical|
|hard to read|easy to read|


## Usage:

- [apply gitscript.sh](./gitscript.sh)
- set rebase as default pull strategy 
- Pull replacement (always rebase with all upper branches)
  - `git pld` - pull latest ***development*** version ( `check + fetch + rebase qa + rebase prod`)
  - `git plq` - pull latest ***qa*** version ( `check + fetch + rebase prod`)
  - `git plprod` - pull latest ***production*** version ( `check + pull`)
- Push (not changed)
- Promote branches (when branches are ready to be promoted to upper(more important) branch, it is only ***fast forwarded***)
  - `git upq` - Apply all changes from ***dev*** to ***qa*** (`rebase --ff-only`)
  - `git upprod` - Apply all changes from ***qa*** to ***production*** (`rebase --ff-only`)
- Conflict
  - if you are on ***dev*** branch use `git divd` - confirmation that ***dev*** branch divergence is resolved and is ready to be forcibly pushed on remote ***dev*** branch branch (`create backup branch + force push from local dev branch`)
  - if you are on ***qa*** branch use`git divq` - confirmation that ***qa*** branch divergence is resolved and is ready to be forcibly pushed on remote ***qa*** branch (`create backup branch + force push from local qa branch`)
    - **corresponding backup_branch** could be kept for a while till you are sure that backup branch is not needed anymore
  - delete `backup_DATE` branch (`if you are sure that all conflict are resolved`)


# Details

If you are using rebases and like its benefits over merge, perhaps you should consider using it on remote branches as well, although it was highly recommended not to till now. Let's , so let's see how it could be used on remote branches (until rebaser it was highly recommended not to use in public branches) .

Therefore it leverages:
 - cleaner history over all project branches instead of the remote one you are working on.
 - moving conflict impact from most important brach to least important brach (by utilizing approach `most important` branch ,  instead of `most used` branch).
 - use `fail fast` approach to conflict resolution with impact on least important branch.
 - use `history is written by winner` approach, instead of The Golden Rule of Rebasing reads: “Never rebase while you're on a public branch.”
 - make QA and Code freeze phase duration flexible instead of fixed (TBD).

# Usage:

- [apply gitscript.sh](./gitscript.sh)
- set rebase as default pull strategy 

## Get latest version

- `git pld` - pull latest ***development*** version ( `check + fetch + rebase qa + rebase prod`)
- `git plq` - pull latest ***qa*** version ( `check + fetch + rebase prod`)
- `git plprod` - pull latest ***production*** version ( `check + pull`)

NOTE: if conflicts appears, like branch divergence DO NOT USE PULL OR MERGE , see following conflict resolution

## Push

- Regular `git push` command can be used (if there are not conflicts after `git pld`)

## Promote branches

When the ***dev*** or ***qa*** branches are ready to be promoted to "upper" branch the following commands could be executed:

- `git upq` - Apply all changes from ***dev*** to ***qa*** (`rebase --ff-only`)
- `git upprod` - Apply all changes from ***qa*** to ***production*** (`rebase --ff-only`)

## Resolve conflicts

  If pl (`pld` or `plq` or `plprod`) fails as branches were diverged, we should do the following:

- resolve conflict and finish (`continue`) rebase process
- if you are on ***dev*** branch use `git divd` - confirmation that ***dev*** branch divergence is resolved and is ready to be forcibly pushed on remote ***dev*** branch branch (`create backup branch + force push from local dev branch`)
- if you are on ***qa*** branch use`git divq` - confirmation that ***qa*** branch divergence is resolved and is ready to be forcibly pushed on remote ***qa*** branch (`create backup branch + force push from local qa branch`)
  - **corresponding backup_branch** could be kept for a while till you are sure that backup branch is not needed anymore
- delete `backup_DATE` branch (`if you are sure that all conflict are resolved`)

# TBD
- show diagram [double rebase flow](temp.md)
- give explanations from TLDR
  - `force push` limitation with backup branches
  - `garbage branch collector`
  - timing concept and branch *delays*
  - dev history and deployment history
- define final name (double rebase flow VS rebaser flow VS mi flow)
