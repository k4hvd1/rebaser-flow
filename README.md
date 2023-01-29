# rebaser-flow

`Resbaser flow` is git flow that uses `rebase` over remote branches as well.

Rebaser flow track project history from ***production perspective*** splitting project history tracking into ***traceable and replaceable tracking***. Therefore it leverages conflict resolution pollution with ***rebasing public branches*** while the code is not in production yet (in replaceable phase), but still in public branches that can be overwritten by ***higher priority branches***. Conflicts are automatically transferred to lower priority branches using a ***fail fast*** approach. Concepts of ***rebase limitation*** and ***following branches*** are implemented via scripting so far.


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
    merge prod tag: "hotfix merge1"
    checkout dev
    merge prod tag: "hotfix merge2"
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

It produces history with no conflicts, and instead of having sequence ***D, B-fix, fix-merge, A-hotfix, hotfix merge1, hotfix merge2***, the one that exists form ***developer perspective***, it produces ***A-hotfix, B-fix, D*** which exist from ***deployment perspective***.

History comparison
|A,B,C,B-fix,B-merge,A-hotfix, hotfix-merge1, hotfix-merge2|A,A-hotfix,B,B-fix,C|
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



Feel free to reach us, if you like this idea,  don't understand the idea, don't like the idea. We are forming a working group for this kind of flow and would be pleased to help you to challange it together, explain it or use it with your team or incorporate new ideas. If you reach us, please type a role you are having: developer, senior developer, team lead, project manager.



# TBD
- update all text from docs
- improve diagram [double rebase flow](temp.md)
- figure out how to show rebase in diagrams
- give explanations from TLDR
  - `force push` limitation with backup branches
  - `garbage branch collector`
  - timing concept and branch *delays*
  - dev history and deployment history
- define final name (double rebase flow VS rebaser flow VS mi flow VS buble flow)
