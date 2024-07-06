import { Application } from "@hotwired/stimulus"
import TextAreaAutogrow from "stimulus-textarea-autogrow"

const application = Application.start()
application.register("textarea-autogrow", TextAreaAutogrow)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
