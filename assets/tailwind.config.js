module.exports = {
  purge: [
    './src/**/*.html',
    './src/**/*.js',
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
  plugins: [],
}
