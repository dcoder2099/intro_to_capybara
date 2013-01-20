# Pragmatic Bookshelf<br>Depot Application

## Smoke Test Plan

### Store

#### Adding Items to the Cart

1. Visit the homepage ("/")
1. Click the "Add to Cart" button for the CoffeeScript book
1. Confirm (after a second) that the cart (left rail) refreshes with the
   CoffeeScript book contained within it.
1. Click the "Add to Cart" button for the Programming Ruby 1.9 book
1. Confirm (after a second) that the cart (left rail) refreshes with the
   Programming Ruby 1.9 book contained within it.

#### Empty Cart

1. Visit the homepage ("/")
1. Click the "Add to Cart" button for the Programming Ruby 1.9 book
1. Confirm (after a second) that the cart (left rail) refreshes with the
   Programming Ruby 1.9 book contained within it.
1. Click the "Empty cart" button (left rail)
1. Confirm (after a second) that the cart is empty (hidden? zero
   dollars? no item rows?)

#### Checkout

1. Visit the homepage ("/")
1. Click the "Add to Cart" button for the CoffeeScript book
1. Confirm (after a second) that the cart (left rail) refreshes with the
   CoffeeScript book contained within it.
1. Click the "Checkout" button (left rail)
1. Confirm the order form is shown.

#### Place Order

1. Visit the homepage ("/")
1. Click the "Add to Cart" button for the CoffeeScript book
1. Confirm (after a second) that the cart (left rail) refreshes with the
   CoffeeScript book contained within it.
1. Click the "Checkout" button (left rail)
1. Confirm the order form is shown.
1. Fill in the Name, Address, and Email text fields
1. Select a Pay type of "Purchase order"
1. Click the "Place Order" button
1. Confirm returning to the homepage with a message of "Thank you for
   your order"

#### Put it altogether...

1. Visit the homepage ("/").
1. Click the "Add to Cart" button for the CoffeeScript book.
1. Confirm that the cart contains the CoffeeScript book.
1. Click the "Add to Cart" button for the Programming Ruby 1.9 book.
1. Confirm that the cart contains the Programming Ruby 1.9 book.
1. Click the "Empty cart" button.
1. Confirm that the cart is empty.
1. Click the "Add to Cart" button for the Rails Test Prescriptions book.
1. Confirm that the cart contains the Rails Test Prescriptions book.
1. Click the "Checkout" button.
1. Confirm the order form is shown.
1. Click the "Place Order" button.
1. Confirm that error messages are displayed for the name, address, email,
   and pay type fields.
1. Fill in the Name, Address, and Email text fields.
1. Select a Pay type of "Purchase order".
1. Click the "Place Order" button.
1. Confirm returning to the homepage with a message of "Thank you for
   your order".

### Backoffice

#### Orders

1. Visit the homepage ("/")
1. Click the "Add to Cart" button for the CoffeeScript book
1. Confirm (after a second) that the cart (left rail ) refreshes with
   the CoffeeScript book contained wihtin it.
1. Click the "Checkout" button (left rail)
1. Fill in the Name, Address, and Email text fields
1. Select a Pay type of "Credit card"
1. Click the "Place Order" button
1. Visit the login screen ("/login")
1. Fill in the Name and Password fields
1. Click the "Login" button
1. Confirm the "Welcome" banner is present
1. Click the "Orders" link
1. Click the "Show" link for the order
1. Confirm the value of the Pay type is "Credit card"
1. Click the "Edit" link
1. Select a Pay type of "Check"
1. Click the "Place Order" button
1. Confirm the flash "Order was successfully updated"
1. Confirm the value of the Pay type is "Check"
1. Click the "Back" link
1. Click the "Destroy" link for the order
1. Click the "Cancel" button on the popup
1. Click the "Orders" link
1. Confirm the order is still there
1. Click the "Destroy" link for the order
1. Click the "Okay" button on the popup
1. Confirm the order is gone

#### Products

1. Visit the login screen ("/login")
1. Fill in the Name and Password fields
1. Click the "Login" button
1. Confirm the "Welcome" banner is present
1. Click the "Products" link
1. Confirm there are three rows in the table
1. Click the "New product" link
1. Fill in the Title and Description fields
1. Click the "Create Product" button
1. Confirm the error flash appears with "Image url can't be blank" and
   "Price is not a number" messages.
1. Fill in the Image url and Price fields
1. Click the "Create Product" button
1. Confirm the flash "Product was successfully created"
1. Click the "Edit" link
1. Change the Price field
1. Click the "Update Product" button
1. Confirm the flash "Product was successfully updated"
1. Click the "Back" link
1. Confirm there are four rows in the table
1. Click the "Destroy" link for the last row
1. Click the "Okay" button on the popup
1. Confirm there are three rows in the table

#### Users

1. Visit the login screen ("/login")
1. Fill in the Name and Password fields
1. Click the "Login" button
1. Confirm the "Welcome" banner is present
1. Click the "Users" link
1. Click the "New User" link
1. Fill in the Name, Password, and Confirm fields
1. Click the "Create User" button
1. Confirm the flash "User #{name} was successfully created."
1. Click the "Logout" button (left rail)
1. Visit the login screen ("/login")
1. Enter the Name and Password fields
1. Click the "Login" button
1. Confirm the "Welcome" banner is present
1. Click the "Users" link
1. Click the "Destroy" link for the user
1. Click the "OK" button on the popup
1. Confirm the login screen is displayed
