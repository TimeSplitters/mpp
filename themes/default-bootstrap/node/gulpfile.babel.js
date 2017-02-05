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
    '../mobile/js/jquery.touchSwipe.min.js',
    '../mobile/js/jquery.idTabs.js',
    '../mobile/js/jquery.bxslider.js',
    '../../../js/jquery/ui/jquery.ui.core.min.js',
    '../../../js/jquery/ui/jquery.ui.widget.min.js',
    '../../../js/jquery/ui/jquery.effects.core.min.js',
    '../../../js/jquery/ui/jquery.effects.highlight.min.js',
    '../../../js/jquery/ui/jquery.ui.effect.min.js',
    '../../../js/jquery/ui/jquery.ui.effect-highlight.min.js',
    '../../../js/jquery/ui/jquery.ui.position.min.js',
    '../../../js/jquery/ui/jquery.ui.menu.min.js',
    '../../../js/jquery/ui/jquery.ui.autocomplete.min.js',
    '../../../js/jquery/plugins/autocomplete/jquery.autocomplete.js',
    '../../../js/jquery/jquery-migrate-1.2.1.min.js',

    '../mobile/js/tether.min.js',
    '../mobile/js/bootstrap.min.js',
    '../mobile/js/bootstrap.offcanvas.min.js',

    '../js/modules/blocksearch/blocksearch.js',
    '../mobile/js/tools.js',
    '../mobile/js/validate.js',
    '../mobile/js/ajax-wishlist.js',
    '../mobile/js/monpotpourri.js'
];

const jsDesktopSources = [
    // commun de base
    '../../../js/jquery/jquery-1.11.0.min.js',
    '../../../js/jquery/jquery-migrate-1.2.1.min.js',
    '../../../js/jquery/plugins/jquery.easing.js',
    '../../../js/jquery/plugins/jquery.idTabs.js',
    '../../../js/jquery/plugins/jquery.scrollTo.js',
    '../../../js/jquery/plugins/jquery.serialScroll.js',
    '../../../js/jquery/plugins/bxslider/jquery.bxslider.js',
    '../../../js/jquery/ui/jquery.ui.core.min.js',
    '../../../js/jquery/ui/jquery.effects.core.min.js',
    '../../../js/jquery/ui/jquery.ui.widget.min.js',
    '../../../js/jquery/ui/jquery.ui.mouse.min.js',
    '../../../js/jquery/ui/jquery.ui.draggable.min.js',
    '../../../js/jquery/ui/jquery.ui.position.min.js',
    //'../../../js/jquery/ui/jquery.ui.tooltip.min.js',
    //'../../../js/jquery/ui/jquery.ui.button.min.js',
    '../../../js/jquery/plugins/autocomplete/jquery.autocomplete.js',
    '../../../js/jquery/plugins/growl/jquery.growl.js',
    '../../../js/jquery/plugins/jquery.typewatch.js',
    '../../../js/jquery/ui/jquery.ui.slider.min.js',
    '../../../js/jquery/ui/jquery.ui.effect.min.js',
    '../../../js/jquery/ui/jquery.ui.effect-highlight.min.js',
    '../../../js/jquery/ui/jquery.effects.highlight.min.js',
    '../../../js/jquery/ui/jquery.ui.sortable.min.js',
    '../../../js/jquery/plugins/footable/jquery.footable.js',
    '../../../js/jquery/plugins/footable-sort/jquery.footable-sort.js',
    '../js/autoload/10-bootstrap.min.js',
    '../../../modules/ganalytics/views/js/GoogleAnalyticActionLib.js',

    // à déterminer
    '../../../modules/socialsharing/js/socialsharing.js',
    '../js/modules/sendtoafriend/sendtoafriend.js',
    '../js/modules/mailalerts/mailalerts.js',
    '../js/modules/productscategory/js/productscategory.js',

    // product + cart + category
    '../js/modules/crossselling/js/crossselling.js',

    // product
    '../../../modules/productcomments/js/jquery.rating.pack.js',
    '../../../modules/productcomments/js/jquery.textareaCounter.plugin.js',
    '../js/modules/productcomments/js/productcomments.js',

    // category
    '../js/modules/blocklayered/blocklayered.js',

    // home
    '../js/modules/homeslider/js/homeslider.js',

    // partout
    '../js/modules/blocknewsletter/blocknewsletter.js',
    '../js/modules/blocksearch/blocksearch.js',
    '../js/modules/blockcart/ajax-cart.js',
    '../js/modules/blocktopmenu/js/hoverIntent.js',
    '../js/modules/blocktopmenu/js/superfish-modified.js',
    '../js/modules/blocktopmenu/js/blocktopmenu.js',
    '../js/modules/blockwishlist/js/ajax-wishlist.js',
    '../../../js/validate.js',
    '../../../js/tools.js',
    '../js/tools/treeManagement.js',
    '../js/tools/vatManagement.js',
    '../js/tools/statesManagement.js',
    '../js/authentication.js',
    '../js/global.js',
];

var cssDesktopCommon = [
    '../css/global.css',
    '../css/modules/blockbestsellers/blockbestsellers.css',
    '../css/modules/blockcart/blockcart.css',
    '../../../js/jquery/plugins/bxslider/jquery.bxslider.css',
    '../css/modules/blockcategories/blockcategories.css',
    '../css/modules/blockcurrencies/blockcurrencies.css',
    '../css/modules/blocklanguages/blocklanguages.css',
    '../css/modules/blockcontact/blockcontact.css',
    '../css/modules/blocknewsletter/blocknewsletter.css',
    '../css/modules/blocksearch/blocksearch.css',
    '../../../js/jquery/plugins/autocomplete/jquery.autocomplete.css',
    '../css/modules/blocktags/blocktags.css',
    '../../../js/jquery/ui/themes/base/jquery.ui.core.css',
    '../../../js/jquery/ui/themes/base/jquery.ui.tooltip.css',
    '../../../js/jquery/ui/themes/base/jquery.ui.theme.css',
    '../../../js/jquery/ui/themes/base/jquery.ui.slider.css',
    //'../../../js/jquery/ui/themes/base/jquery.ui.button.css',
    '../css/modules/blocktopmenu/css/blocktopmenu.css',
    '../css/modules/blocktopmenu/css/superfish-modified.css',
    '../css/modules/blockuserinfo/blockuserinfo.css',
    '../css/modules/blockviewed/blockviewed.css',
    '../css/modules/homeslider/homeslider.css',
    '../css/modules/blockwishlist/blockwishlist.css',
    '../css/modules/productcomments/productcomments.css',
    '../../../js/jquery/plugins/growl/jquery.growl.css',
    '../../../modules/blockpermanentlinks/blockpermanentlinks.css',
    '../../../modules/paypal/views/css/paypal.css',
    '../css/modules/blocklayered/blocklayered.css',
    '../../../modules/socialsharing/css/socialsharing.css',
    '../../../modules/sendtoafriend/sendtoafriend.css',
    '../css/modules/mailalerts/mailalerts.css',
    '../css/modules/productscategory/css/productscategory.css',
    '../css/modules/crossselling/crossselling.css',
    '../css/product_list.css',

    // à la fin on concatène app dans compressed
    '../css/app.css'
];

var scssDesktopPages = [
    '../sass/monpotpourri/404.scss',
    '../sass/monpotpourri/addresses.scss',
    '../sass/monpotpourri/authentication.scss',
    '../sass/monpotpourri/carrousel.scss',
    '../sass/monpotpourri/category.scss',
    '../sass/monpotpourri/cms.scss',
    '../sass/monpotpourri/comparator.scss',
    '../sass/monpotpourri/contact-form.scss',
    '../sass/monpotpourri/discount.scss',
    '../sass/monpotpourri/order.scss',
    '../sass/monpotpourri/order-confirmation.scss',
    '../sass/monpotpourri/order-detail.scss',
    '../sass/monpotpourri/order-opc.scss',
    '../sass/monpotpourri/order-payment.scss',
    '../sass/monpotpourri/password.scss',
    '../sass/monpotpourri/prices-drop.scss',
    '../sass/monpotpourri/print.scss',
    '../sass/monpotpourri/product.scss',
    '../sass/monpotpourri/product_list.scss',
    '../sass/monpotpourri/rtl.scss',
    '../sass/monpotpourri/scenes.scss',
    '../sass/monpotpourri/sitemap.scss',
    '../sass/monpotpourri/stores.scss'
];

var CONFIG;
var concat = require('gulp-concat');
var cleanCSS = require('gulp-clean-css');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var util = require('gulp-util');

gulp.task('build',
    gulp.series(compressCss, jsDesktopFiles)
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
        .pipe(gulp.dest('../mobile/js'))
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

    return gulp.src('../sass/app.scss')
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
            includePaths: ['/Users/christopheabillama/Documents/workspace/monpotpourri/themes/default-bootstrap/node/node_modules/bootstrap/scss', '/Users/christopheabillama/Documents/workspace/monpotpourri/themes/default-bootstrap/mobile/sass', '/Users/christopheabillama/Documents/workspace/monpotpourri/themes/default-bootstrap/sass']
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
    gulp.watch(['../sass/**/*.scss', '../css/**/*.css','!../css/app.css','!../css/compressed.css']).on('change', function(f) {
        if(scssDesktopPages.indexOf(f) == -1 ) {
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

/*
var WebPageTest = require('WebPageTest')
var wpt = new WebPageTest('https://www.webpagetest.org/', 'A.fa24cbace99e330ef674bf090b062fb7');

wpt.runTest('https://www.monpotpourri.com', {
    connectivity: 'Cable',
    location: 'Dulles:Chrome',
    firstViewOnly: false,
    runs: 1,
    video: true
}, function processTestRequest(err, result) {
    console.log(err || result)
});

wpt.getTestStatus('161125_DX_VA6', function processTestStatus(err, result) {
    console.log(err || result)
});

wpt.getTestResults('161125_DX_VA6', function processTestResult(err, result) {
    console.log(err || result)
});

*/