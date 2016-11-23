import gulp     from 'gulp';
import plugins  from 'gulp-load-plugins';
import browser  from 'browser-sync';
import yargs    from 'yargs';
import lazypipe from 'lazypipe';
import fs       from 'fs';
import siphon   from 'siphon-media-query';
import path     from 'path';
import merge    from 'merge-stream';
import beep     from 'beepbeep';
import colors   from 'colors';
import inject   from 'gulp-inject';

const $ = plugins();

// Look for the --production flag
const PRODUCTION = !!(yargs.argv.production);

const jsMobileSources = [
    '../mobile/js/jquery-2.2.4.min.js',
    '../mobile/js/jquery.mobile.custom.min.js',

    '../mobile/js/tether.min.js',
    '../mobile/js/bootstrap.min.js',
    '../mobile/js/bootstrap.offcanvas.min.js',

    '../mobile/js/tools.js',
    '../mobile/js/validate.js',
    '../mobile/js/monpotpourri.js'
];

const jsDesktopSources = [

];

var cssDesktopCommon = [
    '../css/addresses.css'
];

var scssDesktopPages = [
    '../sass/addresses.scss'
];

var CONFIG;
var concat = require('gulp-concat');
var cleanCSS = require('gulp-clean-css');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var util = require('gulp-util');

gulp.task('build',
    gulp.series(compressCss)
);

gulp.task('default',
    gulp.series('build', watch)
);

//a faire a chaque build
function clean(done) {
    done();
}

function copy(done) {
    return gulp.src('node_modules/bootstrap/dist/js/bootstrap.min.js').pipe(gulp.dest('../js'));
}

function jsDesktopFiles(f) {
    util.log(f + ' modified. Now compressing...');
    return gulp.src(jsDesktopSources)
        .pipe(concat('compressed.js'))
        .pipe(gulp.dest('../js'))
        .pipe(uglify())
        .pipe(gulp.dest('../js/'))
        .on('end', function() {
            util.log(' => compressed.js')
        });
}

function jsMobileFiles(f) {
    util.log(f);
    return gulp.src(jsMobileSources)
        .pipe(concat('compressed.js'))
        .pipe(gulp.dest('../mobile/js/'))
        .pipe(uglify())
        .pipe(gulp.dest('../mobile/js/'));
}

function compressCss() {
    return gulp.src(cssDesktopCommon)
        .pipe(concat('compressed.css'))
        .pipe(gulp.dest('../css'))
        .pipe(cleanCSS({ keepSpecialComments: 0 }))
        .pipe(gulp.dest('../css'))
        .on('end', function() {
            util.log(' => compressed.css')
        });
}

function sassDesktopFiles(f) {
    util.log(f);
    return gulp.src(f)
        //.pipe($.if(!PRODUCTION, $.sourcemaps.init()))
        .pipe($.sass({
            includePaths: ['node_modules/bootstrap/scss']
        }).on('error', $.sass.logError))
        //.pipe($.if(!PRODUCTION, $.sourcemaps.write()))
        .pipe(gulp.dest('../css/'))
        .pipe(cleanCSS({ keepSpecialComments: 0 }))
        .pipe(gulp.dest('../css'))
        .on('end', function() {
            util.log(' => app.css');
            compressCss();
        });
}

function sassMobileFiles(f) {
    util.log(f);
    return gulp.src('../mobile/sass/app.scss')
        //.pipe($.if(!PRODUCTION, $.sourcemaps.init()))
        .pipe($.sass({
            includePaths: ['node_modules/bootstrap/scss', '../sass']
        }).on('error', $.sass.logError))
        //.pipe($.if(!PRODUCTION, $.sourcemaps.write()))
        .pipe(gulp.dest('../mobile/css/'))
        .pipe(cleanCSS({ keepSpecialComments: 0 }))
        .pipe(gulp.dest('../mobile/css'));
}

function sassDesktopPages(f) {
    util.log(f);
    return gulp.src(f)
        //.pipe($.if(!PRODUCTION, $.sourcemaps.init()))
        .pipe($.sass({
            includePaths: ['node_modules/bootstrap/scss', '../sass']
        }).on('error', $.sass.logError))
        //.pipe($.if(!PRODUCTION, $.sourcemaps.write()))
        .pipe(gulp.dest('../css/'))
        .pipe(cleanCSS({ keepSpecialComments: 0 }))
        .pipe(gulp.dest('../css'));
}

function watch() {
    gulp.watch(['../sass/**/*.scss', '../css/**/*.css']).on('change', function(f) {
        if(scssDesktopPages.indexOf(f) == -1 && f != '../css/app.css' && f != '../css/compressed.css') {
            sassDesktopFiles(f);
        }
    });
    gulp.watch(scssDesktopPages).on('change', function(f) {
        sassDesktopPages(f);
    });
    gulp.watch(jsDesktopSources).on('change', function(f) {
        jsDesktopFiles(f);
    });

    gulp.watch('../mobile/sass/**/*.scss').on('change', function(f) {
        sassMobileFiles(f);
    });
    gulp.watch(jsMobileSources).on('change', function(f) {
        jsMobileFiles(f);
    });
}