window.addEventListener('message', (event) => {
  const data = event.data
  const container = document.getElementById('container')

  if (data.action === 'show') {
    container.classList.add('show')
  } else if (data.action === 'hide') {
    container.classList.remove('show')
  }
})

document.addEventListener('keydown', (event) => {
  if (event.key === 'Escape') {
    fetch(`https://${GetParentResourceName()}/close`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({}),
    })
  }
})
