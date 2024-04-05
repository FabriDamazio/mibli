// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/mibli_web.ex",
    "../lib/mibli_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        brand: "#FD4F00",
        seasalt: {
          DEFAULT: '#fafafa',
          100: '#323232',
          200: '#646464',
          300: '#969696',
          400: '#c8c8c8',
          500: '#fafafa',
          600: '#fbfbfb',
          700: '#fcfcfc',
          800: '#fdfdfd',
          900: '#fefefe',
        },
        alice_blue: {
          DEFAULT: '#e3f2fd',
          100: '#06375a',
          200: '#0c6eb3',
          300: '#2fa0f1',
          400: '#89c9f7',
          500: '#e3f2fd',
          600: '#e8f5fd',
          700: '#eef7fe',
          800: '#f4fafe',
          900: '#f9fcff',
        },
        indian_red: {
          DEFAULT: '#db5461',
          100: '#320b0e',
          200: '#63151d',
          300: '#95202b',
          400: '#c72a3a',
          500: '#db5461',
          600: '#e27580',
          700: '#e997a0',
          800: '#f0babf',
          900: '#f8dcdf',
        },
        cambridge_blue: {
          DEFAULT: '#8aa29e',
          100: '#1b2120',
          200: '#364341',
          300: '#506461',
          400: '#6b8681',
          500: '#8aa29e',
          600: '#a2b5b1',
          700: '#b9c7c5',
          800: '#d1dad8',
          900: '#e8ecec',
        },
        gunmetal: {
          DEFAULT: '#122932',
          100: '#04080a',
          200: '#071013',
          300: '#0b181d',
          400: '#0e2027',
          500: '#122932',
          600: '#295d72',
          700: '#4193b3',
          800: '#7db8d0',
          900: '#bedce7',
        }
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, {values})
    })
  ]
}
