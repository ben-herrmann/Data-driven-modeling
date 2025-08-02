using LinearAlgebra
using GLMakie,Colors, FileIO
dir = "poincare.jpg"
img = rotr90(Gray.(load(dir)))
X = Float64.(img)


U,σ,V = svd(X, full=false)
Σ = Diagonal(σ)
e = cumsum(σ)/sum(σ)

r = Observable(1)
X̃ = @lift((U[:,1:$r])*(Σ[1:$r,1:$r])*(V[:,1:$r]'))
img_tilde = @lift(Gray.($X̃))

set_theme!(theme_black())
fig = Figure(resolution=(1000,800),fontsize=25)

ax1 = Axis(fig[1,1], aspect = DataAspect(), title="Original")
image!(img)
hidedecorations!(ax1)

ax2 = Axis(fig[1,2], aspect = DataAspect(), title=@lift("Rango = $($r)"))
image!(img_tilde)
hidedecorations!(ax2)

Axis(fig[2,1], title="Valores singulares",xlabel=L"k",ylabel=L"σ_k", yscale=log10)
scatter!(1:length(σ),σ, color=:cyan)
scatter!(@lift([$r]),@lift([σ[$r]]), color=:deeppink, markersize=15)

Axis(fig[2,2], title="Energía acumulada",xlabel=L"k",ylabel=L"e_k")
scatter!(1:length(σ),e, color=:cyan)
scatter!(@lift([$r]),@lift([e[$r]]), color=:deeppink, markersize=15)

sl = Slider(fig[3, 1:2], range = 1:rank(X), startvalue = 1)
connect!(r, sl.value)
fig

# toggle1 = Toggle(fig, active = false)
# label1 = Label(fig, lift(x -> x ? "puntos" : "vectores", toggle1.active))
# vecs = arrows!(zeros(m),zeros(m),zeros(m),X[1,:],X[2,:],X[3,:], arrowsize=0.9,linewidth=0.3, color=(:yellow,1), visible=true)
# pts = meshscatter!(X[1,:],X[2,:],X[3,:],color=(:yellow,1),markersize=0.35, visible = false)

# fig[1, 2] = grid!(hcat(toggle1, label1), tellheight = false)
# connect!(vecs.visible, @lift(~$(toggle1.active)))
# connect!(pts.visible, toggle1.active)
# fig