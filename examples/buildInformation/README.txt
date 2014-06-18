This is a very basic example on how to send data from ElectricCommander to your dashboard

Add the following block to your dashboards/commandertv.erb

    <li data-row="1" data-col="1" data-sizex="2" data-sizey="1">
      <div data-id="lastBuild" data-view="Text" data-addclass-redb="RedBuild" data-addclass-greenb="GreenBuild" data-title="Latest build" data-text="This is your shiny new 1080p dashboard."></div>
    </li>

The color association is done in the widgets/text/text.coffee
text is the type of widgets as referred above in the data-view

The style (and especially the background color) is decribed in the widgets/text/text.scss

Finally add the 2 steps ec_step1.pl and ec_step2.sh in a procedure in Commander.

ec_step1.pl is an ec-perl step that will find a specific job for you and save a few data in properties.
Modify the filter to extract the job you care about.
It saves a few values in job properties

ec_step2.sh is a shell script that will push the data to your dashboard.
The IP address of the server is encoded so modify to fit your needs.

The other important part is the name of your widget "lastBuild" that ties to the definition on the .erb file.
The "color of the build" is also passed "isRed" or "isGreen" to tie to the text.coffee.

Eventually add a schedule around your procedure toupdate your dashboard on a regular basis.

