import { Component, OnInit, isDevMode } from '@angular/core';
import { environment } from '../environments/environment';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
//logic of the component
export class AppComponent {
  title = 'app';
  constructor() {
    console.log("In constructor "+environment.production); // Logs false for default environment
    console.log("${process.env}");
  }

  ngOnInit() {
    console.log("Printing app name =>" + environment.appName);
    console.log("Printing Host name =>" + environment.hostName);
    console.log("Production Mode Host name =>" + environment.production);
    if (isDevMode()) {
      console.log('👋 Development!');
    } else {
      console.log('💪 Production!');
    }
  }

}
