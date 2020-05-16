# npm

## Installation

The best way to install npm is through _nvm (Node Version Manager)_.

On linux, follow [these instructions](https://github.com/nvm-sh/nvm#install--update-script).

On Windows, [install it with Chocolatey](https://chocolatey.org/packages/nvm).

After you have `nvm` installed you can install the latest version of `npm` with:

```powershell
nvm install latest
```

## Remove modules not listed in package.json

```powershell
npm prune
```

## Upgrade your dependencies to the latest versions

```powershell
npm install -g npm-check-updates
ncu
ncu -u
```

See:
- [npm-check-updates](https://www.npmjs.com/package/npm-check-updates)

## How to keep your dependencies up to date

- [npm-outdated](https://docs.npmjs.com/cli/outdated.html)
- [npm-update](https://docs.npmjs.com/cli/update.html)
- [npm-check](https://www.npmjs.com/package/npm-check)
- [Validating dependencies in the project with npm-check and depcheck](https://medium.com/@wlodarczyk_j/validating-dependencies-in-the-project-with-npm-check-and-depcheck-20e83345fc1f)
- [Semantic versioning](https://semver.org/)
