```mermaid
---
title: Standard git approach
---
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
    merge dev
    checkout dev
    commit id: "D"
    checkout qa
    commit id: "Bfix"
    checkout dev
    merge qa tag: "fix merge"
    checkout prod
    commit id: "HOT-A"
    checkout qa
    merge prod tag: "hotfix merge"
    checkout dev
    merge prod tag: "hotfix merge"
    checkout qa
    merge dev
    checkout prod
    merge qa
```

- problem: git history doesn't corresponds to deployment history


```mermaid
---
title: Rebaser git approach
---
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
    merge dev
    checkout qa
    commit id: "Bfix"
    checkout dev
    merge qa tag: "fix rebased"
    commit id: "D"
    checkout prod
    commit id: "HOT-A"
```

```mermaid
---
title: Rebaser git approach
---
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
    merge dev
    checkout prod
    commit id: "HOT-A"
    checkout qa
    merge prod tag:"hotfix rebased"
    commit id: "Bfix"
    checkout dev
    merge qa tag: "fix rebased"
    commit id: "D"

```
