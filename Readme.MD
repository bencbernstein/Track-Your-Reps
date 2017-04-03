- [InstaGov](#instagov)
- [Developer Documentation](#documentation)
- [Vision](#vision)

## <a name="instagov"></a> InstaGov

This is the repository for InstaGov, an iPhone app that aims to give US citizens a direct line of sight to the upcoming actions of their elected representatives.  

Bills and nominations making their way through Congress update the app's interface daily via ProPublica's [Congress Api](https://www.propublica.org/datastore/api/propublica-congress-api).

<p align="center">
<img src="/img/event_table.png" width="250" />
</p>
<br/><br/>
<p align="center">
<img src="/img/rep_summary.png" width="250" />
</p>
<br/><br/>
<p align="center">
<img src="/img/event_summary.png" width="250" />
</p>


## <a name="vision"></a> Vision

**Goal**

InstaGov aims to be a simple, non-opionanted way to understand what your reps in Congress are doing.

We've completed and tested a design and user inteface that users enjoy, but we've run into the well-documented problem of opaque information
from Congress. We've looked through Gov Track, ProPublica, Rep web sites, and other sources, but have ceased development until we have a clear way to get a steady stream of data in plain English.

We hope to discuss with the political and technical communities ways we might achieve this. We hope to collaborate in order to solve this seemingly simple but daunting problem.


## <a name="documentation"></a> Developer Documentation

**Overview**

InstaGov is architected with the tradional [MVC framework](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller). The constraints have all been done programmatically.

Data for the running of app is sourced internally from the [Data](https://github.com/bencbernstein/Track-Your-Reps/tree/master/Track%20Your%20Reps/Lib/Data) and [Images](https://github.com/bencbernstein/Track-Your-Reps/tree/master/Track%20Your%20Reps/Assets.xcassets/Images) folders, and externally from ProPublica's [Congress API](https://www.propublica.org/datastore/api/propublica-congress-api). The only data persisted on users' devices through sessions is the user's (American) state.

**Parts of Interest**

1. Calling the ProPublica's API and initializing the app's state in a timely manner was a tricky technical challenge. There are numerous endpoints that need to be hit, and the data receieved has to be merged with internal data that has been sourced from other places (like Wikipedia and senate.gov).  Most of this logic exists in [User.swift](https://github.com/bencbernstein/Track-Your-Reps/blob/master/Track%20Your%20Reps/Models/User.swift).

2. Networking with ProPublica's API is achieved through the use of 3rd party library [Moya](https://github.com/Moya/Moya). [ProPublicaProvider](https://github.com/bencbernstein/Track-Your-Reps/blob/master/Track%20Your%20Reps/Networking/ProPublicaProvider.swift) and [ProPublicaAPI](https://github.com/bencbernstein/Track-Your-Reps/blob/master/Track%20Your%20Reps/Networking/ProPublicaAPI.swift) provide and easy to use, and quick to understand abstraction layer.
