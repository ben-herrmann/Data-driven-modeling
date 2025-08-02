include("draw_vectors.jl")

U = [3.0 7.0;
     4.0 3.0;
     1.0 2.0]

v = [3.0;
    -5.0;
     3.0]

P = U*inv(U'*U)*U'

l = 1.2*norm(U)
set_theme!(theme_black())
fig = Figure(resolution=(1500,1200),
               fontsize=40)
ax = Axis3(fig[1,1],viewmode=:fit,
           limits=(-l,l,-l,l,-l,l),
           aspect=:data)
vectors!(U,color=:yellow)
plane!(U, color=(:cyan,0.6))
vector!(v,color=:deeppink)
vector!(P*v,color=:orange)
vector!((I-P)*v,color=:cyan)
fig