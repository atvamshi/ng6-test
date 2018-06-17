import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import {UsersComponent} from './users/users.component';
import {DetailsComponent} from './details/details.component';
import {PostsComponent} from './posts/posts.component';
import { SidebarComponent } from './sidebar/sidebar.component';

const routes: Routes = [
  // {
  //   path: '',//intial path
  //   component: SidebarComponent,
  // },
  {
    path: '',//intial path
    component: UsersComponent,
  },
  {
    path: 'details/:id',//URL parameter *** :) very imp /
    component: DetailsComponent
  },
  {
    path: 'posts',
    component: PostsComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
