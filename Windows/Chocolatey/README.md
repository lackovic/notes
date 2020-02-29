# Chocolatey

[Chocolatey](https://chocolatey.org/) is a package manager for Windows.

## Installs a list of packages in bulk

```powershell
cinst .\packages.config -y
```

See [`.\packages.config`](packages.config) for reference.

## Update all installed software

```powershell
cup all -y
```

## List installed software

```powershell
clist -l
```
