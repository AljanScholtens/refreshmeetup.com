const autoprefixer = require("autoprefixer");
const browsersync = require("browser-sync").create();
const cp = require("child_process");
const cssnano = require("cssnano");
const del = require("del");
const eslint = require("gulp-eslint");
const gulp = require("gulp");
const imagemin = require("gulp-imagemin");
const newer = require("gulp-newer");
const plumber = require("gulp-plumber");
const postcss = require("gulp-postcss");
const rename = require("gulp-rename");

const cssnano = require('gulp-cssnano')
const atImport = require('postcss-import')

const nunjucks = require('gulp-nunjucks')
const browsersync = require('browser-sync').create()

function browserSync(done) {
  browsersync.init({
    server: {
      baseDir: "./dist/"
    },
    port: 3000
  });
  done();
}

// BrowserSync Reload
function browserSyncReload(done) {
  browsersync.reload();
  done();
}

// CSS task
function css() {
  return gulp
    .src("./src/assets/stylesheets/styles.css")
    .pipe(plumber())
    .pipe(sass({ outputStyle: "expanded" }))
    .pipe(gulp.dest("./_site/assets/css/"))
    .pipe(rename({ suffix: ".min" }))
    .pipe(postcss([autoprefixer(), cssnano(), cssnext(), atImport()]))
    .pipe(gulp.dest("./dist/assets/stylesheets/"))
    .pipe(browsersync.stream());
}

// Watch files
function watchFiles() {
  gulp.watch("./src/assets/stylesheets/**/*", css);
  gulp.watch("./assets/js/**/*", gulp.series(scriptsLint, scripts));
}
