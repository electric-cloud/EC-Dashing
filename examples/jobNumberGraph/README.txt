This example is to show how to create a simple chart by pushing some data from Commander and graphing them in the dashboard using the RickshawGraph package

Add the folloing block to your dashboards/commandertv.erb

    <li data-row="1" data-col="1" data-sizex="2" data-sizey="1">
      <div data-id="jobTrend" data-view="Trend" data-title="Builds per day"></div>
    </li>

data-id="jobTrend" is the id used when you push the data from Commander
data-view="Trend" is the name of the widget used to indicate how to display the data. That way you can use the same kind of widgets to display different set of data

As usual the style is in widgets/trend/trend.scss

The widget code is written in CoffeeScript in widgets/trend/trend.coffee This is a very basic example, the full implementation can be found at https://gist.github.com/jwalton/6614023

ec_step1.pl is the code to extract the total numbers of successful jobs over the last 10 days
it sends data to dashing using a curl command. The data is passed as following:

	"points": [{"x": 1402383600, "y": 108}, {"x": 1402470000, "y": 145}]

where x is an epoch time (in seconds) and y the number of successfull daily jobs.
