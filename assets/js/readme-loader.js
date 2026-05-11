function loadReadme(owner, repo, branch) {
  if (!owner || !repo || !branch) {
    showError('Missing required fields: owner, repo, or branch');
    return;
  }

  const cacheKey = `readme:${owner}/${repo}/${branch}`;
  const cached = sessionStorage.getItem(cacheKey);

  if (cached) {
    const readmeDiv = document.getElementById('readme');
    document.getElementById('readme-loading').style.display = 'none';
    readmeDiv.innerHTML = cached;
    fixRelativePaths(readmeDiv, `https://raw.githubusercontent.com/${owner}/${repo}/${branch}/`);
    return;
  }

  const readmeUrl = `https://raw.githubusercontent.com/${owner}/${repo}/${branch}/README.md`;
  const baseUrl = `https://raw.githubusercontent.com/${owner}/${repo}/${branch}/`;

  fetch(readmeUrl)
    .then(response => {
      if (!response.ok) {
        throw new Error(`Failed to fetch README (${response.status})`);
      }
      return response.text();
    })
    .then(markdown => {
      const html = marked.parse(markdown);
      const readmeDiv = document.getElementById('readme');

      document.getElementById('readme-loading').style.display = 'none';
      readmeDiv.innerHTML = html;
      fixRelativePaths(readmeDiv, baseUrl);

      try {
        sessionStorage.setItem(cacheKey, html);
      } catch (_) {
      }
    })
    .catch(error => {
      showError(error.message);
    });
}

function fixRelativePaths(container, baseUrl) {
  const images = container.querySelectorAll('img');
  images.forEach(img => {
    const src = img.getAttribute('src');
    if (src && !src.startsWith('http://') && !src.startsWith('https://') && !src.startsWith('data:')) {
      const cleanSrc = src.replace(/^\.\//, '');
      img.setAttribute('src', baseUrl + cleanSrc);
    }
  });

  const links = container.querySelectorAll('a');
  links.forEach(link => {
    const href = link.getAttribute('href');
    if (href && !href.startsWith('http://') && !href.startsWith('https://') && !href.startsWith('#') && !href.startsWith('mailto:')) {
      const cleanHref = href.replace(/^\.\//, '');
      link.setAttribute('href', baseUrl + cleanHref);
      link.setAttribute('target', '_blank');
    }
  });
}

function showError(message) {
  document.getElementById('readme-loading').style.display = 'none';
  document.getElementById('readme-error').style.display = 'block';
  document.getElementById('error-message').textContent = message;
}
