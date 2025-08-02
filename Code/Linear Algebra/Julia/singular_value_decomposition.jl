include("draw_vectors.jl")

m = 100
X = [3 7 0; 7 3 0 ; 1 2 1.5]*randn(3,m)
U,σ,V = svd(X)
Σ = Diagonal(σ)

l = 20
set_theme!(theme_black())
fig = Figure(resolution=(1500,1200),fontsize=25)
ax = Axis3(fig[1,1],viewmode=:fit,
           limits=(-l,l,-l,l,-l,l),aspect=:data)

toggle1 = Toggle(fig, active = false)
label1 = Label(fig, lift(x -> x ? "puntos" : "vectores", toggle1.active))
vecs = vectors!(X,color=(:yellow,1), visible=true)
#arrows3d!(zeros(m),zeros(m),zeros(m),X[1,:],X[2,:],X[3,:], markerscale=0.2, color=(:yellow,1), visible=true)
pts = meshscatter!(X[1,:],X[2,:],X[3,:],color=(:yellow,1),markersize=0.35, visible = false)

toggle2 = Toggle(fig, active = false)
label2 = Label(fig, lift(x -> x ? "base visible" : "base invisible", toggle2.active))
A = U*sqrt(Σ)

basis = vectors!(A,color=:deeppink)
arrows3d!(zeros(m),zeros(m),zeros(m),A[1,:],A[2,:],A[3,:], markerscale=0.3,color=:deeppink)

X1d = U[:,1]*Σ[1,1]*V[:,1]'
sub1d = vectors!([σ[1]*U[:,1] -σ[1]*U[:,1]], color = :cyan)
vecs1d = vectors!(X1d, color = :orange)

# X2d = U[:,1:2]*Σ[1:2,1:2]*V[:,1:2]'
# sub2d = plane!(U*Σ/6, color=:cyan)
# vecs2d = vectors!(X2d, color = :orange)

fig[1, 2] = grid!(hcat([toggle1,toggle2], [label1,label2]), tellheight = false)
connect!(vecs.visible, @lift(~$(toggle1.active)))
connect!(pts.visible, toggle1.active)
connect!(basis.visible, toggle2.active)
fig
