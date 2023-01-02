# rebaser-flow


# TLDR;

`Resbaser flow` is git flow that uses `rebase` over remote branches as well. Therefore it leverages:
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