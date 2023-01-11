# Standard git approach
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

- problem: git history doesn't corresponds to deployment history. Sequence D, B-fix, A instead of A, B-fix, D


# Rebaser git approach

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
    checkout qa
    commit id: "B-fix"
    checkout dev
    merge qa tag: "fix rebased"
    commit id: "D"
    checkout prod
    commit id: "A-hotfix"
```

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

