module.exports = {
    mode: "jit",
    purge: [
      "./js/**/*.js", 
      "../lib/*_web/**/*.*ex",
      "../lib/*_web/*.html.eex",
      "../lib/*_web/*.html.leex",
      "../lib/*_web/live/**/*.ex",
      "../lib/*_web/live/**/*.sface",
      "../lib/*_web/components/**/*.ex",
      "../lib/*_web/components/**/*.sface",
      "../lib/*_web/global_components/**/*.ex",
      "../lib/*_web/**/global_components/**/*.sface",
    ],
    darkMode: 'class', // or 'media' or 'class'
    theme: {
      extend: {},
      maxHeight: {
        '100': '30rem',
        '106': '36rem'
      }
    },
    variants: {
      extend: {
        translate: ['motion-reduce']
      },
      width: ['responsive', 'hover', 'focus']
    },
    plugins: [
      require('@tailwindcss/forms'),
    ],
  };
  