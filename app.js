const seedProducts=[
{id:1,name:"Mouse inalámbrico",category:"Periféricos",stock:42,min:15,price:12500,icon:"🖱️"},
{id:2,name:"Teclado mecánico",category:"Periféricos",stock:8,min:10,price:38900,icon:"⌨️"},
{id:3,name:"Monitor 24 pulgadas",category:"Electrónica",stock:16,min:5,price:189000,icon:"🖥️"},
{id:4,name:"Cable HDMI 2m",category:"Accesorios",stock:4,min:12,price:6500,icon:"🔌"},
{id:5,name:"Disco SSD 1TB",category:"Almacenamiento",stock:21,min:8,price:89500,icon:"💾"},
{id:6,name:"Resma A4",category:"Oficina",stock:0,min:10,price:7200,icon:"📄"},
{id:7,name:"Auriculares USB",category:"Accesorios",stock:18,min:6,price:21400,icon:"🎧"},
{id:8,name:"Webcam HD",category:"Electrónica",stock:11,min:5,price:32900,icon:"📷"}
];
const $=s=>document.querySelector(s);
let products=JSON.parse(localStorage.getItem("stockpilot-products")||"null")||seedProducts;
let movements=JSON.parse(localStorage.getItem("stockpilot-movements")||"null")||[
{date:"06/11/2026 10:35",name:"Mouse inalámbrico",type:"Entrada",qty:12,detail:"Reposición de mercadería"},
{date:"05/11/2026 15:20",name:"Teclado mecánico",type:"Salida",qty:2,detail:"Pedido de cliente"},
{date:"05/11/2026 11:05",name:"Monitor 24 pulgadas",type:"Entrada",qty:5,detail:"Ingreso de proveedor"}
];
const money=n=>new Intl.NumberFormat("es-AR",{style:"currency",currency:"ARS",maximumFractionDigits:0}).format(n);
const save=()=>{localStorage.setItem("stockpilot-products",JSON.stringify(products));localStorage.setItem("stockpilot-movements",JSON.stringify(movements));};
const status=p=>p.stock===0?["Sin stock","out"]:p.stock<=p.min?["Stock bajo","low"]:["Disponible","ok"];
const escapeHTML=s=>String(s).replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]));
function productRow(p,withActions=false){const [label,cls]=status(p);return `<tr><td><div class="product-cell"><span class="product-icon">${p.icon||"📦"}</span>${escapeHTML(p.name)}</div></td><td><span class="category-pill">${escapeHTML(p.category)}</span></td><td class="stock-cell">${p.stock} u.</td>${withActions?`<td>${p.min} u.</td>`:""}<td>${money(p.price)}</td><td><span class="status ${cls}">${label}</span></td>${withActions?`<td><div class="adjust"><button data-adjust="-1" data-id="${p.id}" aria-label="Restar una unidad">−</button><button data-adjust="1" data-id="${p.id}" aria-label="Sumar una unidad">+</button></div></td>`:`<td><button class="mini-btn" data-quick-add="${p.id}" title="Sumar una unidad">＋</button></td>`}</tr>`;}
function render(){
const low=products.filter(p=>p.stock<=p.min);
$("#stat-products").textContent=products.length;
$("#stat-units").textContent=products.reduce((s,p)=>s+p.stock,0).toLocaleString("es-AR");
$("#stat-low").textContent=low.length;
$("#stat-value").textContent=money(products.reduce((s,p)=>s+p.stock*p.price,0));
const categories=[...new Set(products.map(p=>p.category))].sort();
const select=$("#category-filter"),selected=select.value;
select.innerHTML='<option value="all">Todas las categorías</option>'+categories.map(c=>`<option value="${escapeHTML(c)}">${escapeHTML(c)}</option>`).join("");
select.value=categories.includes(selected)?selected:"all";
const q=$("#search").value.toLowerCase();
const filtered=products.filter(p=>(p.name+" "+p.category).toLowerCase().includes(q)&&(select.value==="all"||p.category===select.value));
$("#product-rows").innerHTML=filtered.slice(0,6).map(p=>productRow(p)).join("")||'<tr><td colspan="6">No se encontraron productos.</td></tr>';
$("#table-count").textContent=`Mostrando ${Math.min(filtered.length,6)} de ${filtered.length} productos`;
$("#all-product-rows").innerHTML=products.map(p=>productRow(p,true)).join("");
$("#alert-count").textContent=low.length;
$("#alerts-list").innerHTML=low.length?low.map(p=>`<div class="alert-item"><span class="alert-symbol">⚠</span><div><strong>${escapeHTML(p.name)}</strong><small>${p.stock===0?"Sin unidades disponibles":`Quedan ${p.stock} unidades · Mínimo ${p.min}`}</small></div></div>`).join(""):'<div class="empty-state">¡Todo en orden! No hay alertas de stock.</div>';
$("#movement-rows").innerHTML=movements.map(m=>`<tr><td>${m.date}</td><td>${escapeHTML(m.name)}</td><td><span class="status ${m.type==="Entrada"?"ok":"low"}">${m.type}</span></td><td>${m.qty} u.</td><td>${escapeHTML(m.detail)}</td></tr>`).join("");
$("#empty-movements").classList.toggle("hidden",movements.length>0);
}
function setView(view){["dashboard","inventory","movements"].forEach(v=>{$("#"+v+"-view").classList.toggle("hidden",v!==view);});document.querySelectorAll(".nav-link").forEach(b=>b.classList.toggle("active",b.dataset.view===view));const labels={dashboard:"Resumen",inventory:"Inventario",movements:"Movimientos"};$("#crumb").textContent=labels[view];$("#page-title").textContent=view==="dashboard"?"Resumen de inventario":labels[view];$("#page-subtitle").textContent=view==="dashboard"?"Una vista clara del estado de tus productos y movimientos.":view==="inventory"?"Consultá y ajustá las existencias de cada producto.":"Seguimiento de entradas y salidas del inventario.";}
document.querySelectorAll("[data-view]").forEach(b=>b.addEventListener("click",()=>setView(b.dataset.view)));
$("#search").addEventListener("input",render);$("#category-filter").addEventListener("change",render);$("#search-all").addEventListener("input",()=>{const q=$("#search-all").value.toLowerCase();$("#all-product-rows").innerHTML=products.filter(p=>(p.name+" "+p.category).toLowerCase().includes(q)).map(p=>productRow(p,true)).join("");});
function adjust(id,delta){const p=products.find(x=>x.id===Number(id));if(!p)return;if(delta<0&&p.stock===0)return;p.stock+=delta;movements.unshift({date:new Date().toLocaleString("es-AR",{dateStyle:"short",timeStyle:"short"}),name:p.name,type:delta>0?"Entrada":"Salida",qty:Math.abs(delta),detail:"Ajuste manual de demostración"});save();render();}
document.addEventListener("click",e=>{const a=e.target.closest("[data-adjust]");const q=e.target.closest("[data-quick-add]");if(a)adjust(a.dataset.id,Number(a.dataset.adjust));if(q)adjust(q.dataset.quickAdd,1);});
const dialog=$("#product-dialog");$("#add-product-btn").addEventListener("click",()=>dialog.showModal());$("#close-dialog").addEventListener("click",()=>dialog.close());
$("#product-form").addEventListener("submit",e=>{e.preventDefault();const f=new FormData(e.currentTarget);const name=String(f.get("name")).trim();if(!name)return;const stock=Number(f.get("stock"));const p={id:Date.now(),name,category:f.get("category"),stock,min:Number(f.get("minimum")),price:Number(f.get("price")),icon:"📦"};products.unshift(p);if(stock>0)movements.unshift({date:new Date().toLocaleString("es-AR",{dateStyle:"short",timeStyle:"short"}),name,type:"Entrada",qty:stock,detail:"Alta de producto"});save();render();e.currentTarget.reset();dialog.close();});
$("#today").textContent=new Date().toLocaleDateString("es-AR",{weekday:"short",day:"numeric",month:"short",year:"numeric"});
render();