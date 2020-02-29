(function exportSEs() {
  /* Auxiliary function to download a file with the exported data */
  function downloadData(filename, data) {
    const file = new File([data], { type: "text/json" });
    const elem = document.createElement("a");
    elem.href = URL.createObjectURL(file);
    elem.download = filename;
    elem.click();
  }

  /* Actual search engine export magic */
  settings.SearchEnginesBrowserProxyImpl.prototype
    .getSearchEnginesList()
    .then(searchEngines => {
      downloadData("search_engines.json", JSON.stringify(searchEngines.others));
    });
})();
