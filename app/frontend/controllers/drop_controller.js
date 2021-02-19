import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["output"]

  drop() {
      let bulmaBurger=this.outputTarget.classList
      if (bulmaBurger.value.includes("is-active")){
       this.outputTarget.classList.remove("is-active");
      }else{
       this.outputTarget.classList.add("is-active");
      }
   
  }

}
