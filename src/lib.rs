use leptos::*;
use wasm_bindgen::prelude::*;

#[wasm_bindgen(start)]
pub fn start() {
    mount_to_body(|| {
        view! { <App/> }
    })
}

#[component]
fn App() -> impl IntoView {
    view! {
        <div class="max-w-2xl mx-auto py-8 px-4">
            <h1 class="text-center pb-2">"UNAVI"</h1>
        </div>
    }
}
