(async function importSEs() {
  /* Auxiliary function to open a file selection dialog */
  function selectFileToRead() {
    return new Promise(resolve => {
      const input = document.createElement("input");
      input.setAttribute("type", "file");
      input.addEventListener(
        "change",
        e => {
          resolve(e.target.files[0]);
        },
        false
      );
      input.click();
    });
  }

  /* Auxiliary function to read data from a file */
  function readFile(file) {
    return new Promise(resolve => {
      const reader = new FileReader();
      reader.addEventListener("load", e => {
        resolve(e.target.result);
      });
      reader.readAsText(file);
    });
  }

  const file = await selectFileToRead();
  const content = await readFile(file);
  const searchEngines = JSON.parse(content);
  searchEngines.forEach(({ name, keyword, url }) => {
    /* Actual search engine import magic */
    chrome.send("searchEngineEditStarted", [-1]);
    chrome.send("searchEngineEditCompleted", [name, keyword, url]);
  });
})();
