# Chocolatey

[Chocolatey](https://chocolatey.org/) is a package manager for Windows.

## Install a list of packages in bulk

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

## Install a specific version

```powershell
choco install bulkrenameutility --version=3.4.0.0 -y
```

## Pin a package to suppress upgrades

```powershell
choco pin add -n=ruby
```

- [Source](https://superuser.com/a/972614/54747)
