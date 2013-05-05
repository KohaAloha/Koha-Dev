<script type="text/javascript">
//<![CDATA[

var debug    = "[% debug %]";
var dformat  = "[% dateformat %]";
var sentmsg = 0;
if (debug > 1) {alert("dateformat: " + dformat + "\ndebug is on (level " + debug + ")");}

function Date_from_syspref(dstring) {
        var dateX = dstring.split(/[-/]/);
        if (debug > 1 && sentmsg < 1) {sentmsg++; alert("Date_from_syspref(" + dstring + ") splits to:\n" + dateX.join("\n"));}
        if (dformat === "iso") {
                return new Date(dateX[0], (dateX[1] - 1), dateX[2]);  // YYYY-MM-DD to (YYYY,m(0-11),d)
        } else if (dformat === "us") {
                return new Date(dateX[2], (dateX[0] - 1), dateX[1]);  // MM/DD/YYYY to (YYYY,m(0-11),d)
        } else if (dformat === "metric") {
                return new Date(dateX[2], (dateX[1] - 1), dateX[0]);  // DD/MM/YYYY to (YYYY,m(0-11),d)
        } else {
                if (debug > 0) {alert("KOHA ERROR - Unrecognized date format: " +dformat);}
                return 0;
        }
}

/* Instead of including multiple localization files as you would normally see with
   jQueryUI we expose the localization strings in the default configuration */
jQuery(function($){
    $.datepicker.regional[''] = {
        closeText: _("Done"),
        prevText: _("Prev"),
        nextText: _("Suivant"),
        currentText: _("Aujourd'hui"),
        monthNames: [_("Janvier"),_("Février"),_("Mars"),_("Avril"),_("May"),_("Juin"),
        _("Juillet"),_("Août"),_("Septembre"),_("Octobre"),_("Novembre"),_("Décembre")],
        monthNamesShort: [_("Jan"), _("Fév"), _("Mar"), _("Avr"), _("May"), _("Jui"),
        _("Jul"), _("Aoû"), _("Sep"), _("Oct"), _("Nov"), _("Déc")],
        dayNames: [_("Dimanche"), _("Lundi"), _("Mardi"), _("Mercredi"), _("Jeudi"), _("Vendredi"), _("Samedi")],
        dayNamesShort: [_("Dim"), _("Mon"), _("Mar"), _("Mer"), _("Jeu"), _("Ven"), _("Sam")],
        dayNamesMin: [_("Su"),_("Mo"),_("Tu"),_("We"),_("Th"),_("Fr"),_("Sa")],
        weekHeader: _("Wk"),
        dateFormat: '[% IF ( dateformat_us ) %]mm/dd/yy[% ELSIF ( dateformat_metric ) %]dd/mm/yy[% ELSE %]yy-mm-dd[% END %]',
        firstDay: [% CalendarFirstDayOfWeek %],
        isRTL: [% IF ( bidi ) %]true[% ELSE %]false[% END %],
        showMonthAfterYear: false,
        yearSuffix: ''};
    $.datepicker.setDefaults($.datepicker.regional['']);
});

$(document).ready(function(){

$.datepicker.setDefaults({
        showOn: "both",
        changeMonth: true,
        changeYear: true,
        buttonImage: '[% interface %]/lib/famfamfam/silk/calendar.png',
        buttonImageOnly: true,
        showButtonPanel: true,
        showOtherMonths: true
    });

    $( ".datepicker" ).datepicker();
    // http://jqueryui.com/demos/datepicker/#date-range
    var dates = $( ".datepickerfrom, .datepickerto" ).datepicker({
        changeMonth: true,
        numberOfMonths: 1,
        onSelect: function( selectedDate ) {
            var option = this.id == "from" ? "minDate" : "maxDate",
                instance = $( this ).data( "datepicker" );
                date = $.datepicker.parseDate(
                    instance.settings.dateFormat ||
                    $.datepicker._defaults.dateFormat,
                    selectedDate, instance.settings );
            dates.not( this ).datepicker( "option", option, date );
        }
    });
});
//]]>
</script>
