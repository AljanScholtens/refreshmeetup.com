{% extends 'layout/layout.empty.html' %}

{% block content %}

  <h2 class="heading--h1">Next meetups</h2>

  <h3 class="u-uppercase">Upcoming in 2018</h3>

  <div class="o-card o-card--white o-card--row o-card--clickable">
    <a href="https://www.meetup.com/refresh-groningen/events/242086072/" class="o-card__link">
      <span class="o-card__time">20 feb</span>
      <span class="o-card__event">S0404 - Design Thinking by Ryco Wolbers</span>
    </a>
  </div>

  <div class="o-card o-card--white o-card--row o-card--clickable">
    <a href="https://www.meetup.com/refresh-groningen/events/242086082/" class="o-card__link">
      <span class="o-card__time">24 apr</span>
      <span class="o-card__event">S0405 - TBA</span>
    </a>
  </div>

  <div class="o-card o-card--white o-card--row o-card--clickable">
    <a href="https://www.meetup.com/refresh-groningen/events/242086109/" class="o-card__link">
      <span class="o-card__time">19 jun</span>
      <span class="o-card__event">S0406 - TBA</span>
    </a>
  </div>

  <!--<div class="o-card o-card--white o-card--row o-card--clickable">
    <a href="https://www.meetup.com/refresh-groningen/events/242086082/" class="o-card__link">
      <span class="o-card__time">24 apr</span>
      <span class="o-card__event">S0405 - TBA</span>
    </a>
  </div>

  <div class="o-card o-card--white o-card--row o-card--clickable">
    <a href="https://www.meetup.com/refresh-groningen/events/242086109/" class="o-card__link">
      <span class="o-card__time">19 jun</span>
      <span class="o-card__event">S0406 - TBA</span>
    </a>
  </div> -->

  <p class="paragraph--small">Want to join our Slack team? Join Refresh via <a href="http://meetup.com/refresh-groningen">Meetup.com</a> and we'll get you in. </p>

  <!-- <p>Looking for a job? We're keeping track of <a href="/jobs.php">design &amp; front-end jobs</a> near Groningen.</p> -->

  <h2>Sponsors</h2>
  <ul class="o-logos">
    <li class="o-logos__item"><a href="https://www.wearespindle.com" style="background-image:url('dist/images/logo-spindle.svg')"></a></li>
    <li class="o-logos__item"><a href="https://hackerone.com" style="background-image:url('dist/images/logo-hackerone.svg')"></a></li>
  </ul>

{% endblock %}
