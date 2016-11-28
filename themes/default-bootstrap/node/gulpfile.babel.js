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
    //'../mobile/js/jquery.mobile.custom.min.js',

    '../mobile/js/tether.min.js',
    '../mobile/js/bootstrap.min.js',
    '../mobile/js/bootstrap.offcanvas.min.js',

    '../mobile/js/tools.js',
    '../mobile/js/validate.js',
    '../mobile/js/monpotpourri.js'
];

var CONFIG;
var concat = require('gulp-concat');
var cleanCSS = require('gulp-clean-css');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var util = require('gulp-util');

gulp.task('default',
    gulp.series(jsMobileFiles, sassMobileFiles)
);

//a faire a chaque build
function clean(done) {
    done();
}

function jsMobileFiles() {
    return gulp.src(jsMobileSources)
        .pipe(concat('compressed.js'))
        .pipe(gulp.dest('../mobile/js/'))
        .pipe(uglify())
        .pipe(gulp.dest('../mobile/js/'));
}

function sassMobileFiles() {
    return gulp.src('../mobile/sass/app.scss')
        .pipe($.sass({
            includePaths: ['node_modules/bootstrap/scss', '../sass']
        }).on('error', $.sass.logError))
        //.pipe($.if(!PRODUCTION, $.sourcemaps.write()))
        .pipe(gulp.dest('../mobile/css/'))
        .pipe(cleanCSS({ keepSpecialComments: 0 }))
        .pipe(gulp.dest('../mobile/css'));
}