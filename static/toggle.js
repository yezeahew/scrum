document.addEventListener('DOMContentLoaded', (event) => {
    const themeSwitcher = document.getElementById('checkbox');
    const currentTheme = localStorage.getItem('theme');

    if (currentTheme === 'dark') {
        document.body.classList.add('dark-mode');
        themeSwitcher.checked = true;
    }

    themeSwitcher.addEventListener('change', () => {
        document.body.classList.toggle('dark-mode');
        let theme = 'light';
        if (document.body.classList.contains('dark-mode')) {
            theme = 'dark';
        }
        localStorage.setItem('theme', theme);
    });
});
