import { Component, OnInit } from '@angular/core';
import {DataService} from '../data.service';
import {Observable} from 'rxjs';
import {ActivatedRoute} from '@angular/router' //new componet and is important

@Component({
  selector: 'app-details',
  templateUrl: './details.component.html',
  styleUrls: ['./details.component.scss']
})
export class DetailsComponent implements OnInit {

  user$: any; //below line is good this temporary
  // user$: Object; 


  constructor(private data: DataService, private route : ActivatedRoute) {
    this.route.params.subscribe(params => this.user$ = params.id)  //ref to the routing
  }

  ngOnInit() {
    this.data.getUser(this.user$).subscribe(
      data => this.user$ = data
    )
  }

}
