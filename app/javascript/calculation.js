function calculation (){

  const itemPrice = this.document.getElementById("item-price");
  const addTaxPrice = this.document.getElementById("add-tax-price");
  const profit = this.document.getElementById("profit");

  itemPrice.addEventListener('keyup', function(){
    
    const price = itemPrice.value
    const commission = Math.floor(price * 0.1)

    addTaxPrice.textContent = commission.toLocaleString();
    profit.textContent = (price - commission).toLocaleString();
    
  });
};

window.addEventListener('load' , calculation);